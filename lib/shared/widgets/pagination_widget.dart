import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:reddit/core/core.dart';
import 'package:reddit/util/toast_util.dart';

import '../../page/home/widget/post_list_item.dart';

/**
 * @description: PaginationWidget atende aos requisitos da paginação, recebendo uma lista com X itens como parametro
 * e limitando a visualização de cada pagina como 10
 */
class PaginationWidget extends StatefulWidget {
  final List<dynamic> itens;
  const PaginationWidget({super.key, required this.itens});

  @override
  State<PaginationWidget> createState() => _PaginationWidgetState();
}

class _PaginationWidgetState extends State<PaginationWidget> {
  List<dynamic> itensPerPage = [];
  List<dynamic> backupList = [];
  bool _isFirstPage = true, _isLoading = false, _isLastPage = false;
  int firstItemIndex = 0, lastItemIndex = 10, qntPerPage = 10;

  @override
  void initState() {
    backupList.addAll(widget.itens);

    loadListData();
    super.initState();
  }

  loadListData() async {
    print('> Carregando Pagina');

    itensPerPage.addAll(backupList.take(10));

    setState(() {});
  }

  onPreviousPage() async {
    setState(() {
      _isLoading = !_isLoading;
    });

    backupList.clear();
    backupList.addAll(widget.itens);

    firstItemIndex = 0;
    lastItemIndex = 10;

    await Future.delayed(const Duration(milliseconds: 500))
        .then((value) => loadListData());

    setState(() {
      _isLoading = !_isLoading;
    });
  }

  onNextPage() async {
    if (!_isLastPage) {
      setState(() {
        _isLoading = !_isLoading;
      });

      itensPerPage.forEach((element) {
        backupList.remove(element);
        print('> Removendo Item');
      });

      firstItemIndex = lastItemIndex;

      if (backupList.length <= 10) {
        qntPerPage = backupList.length;
        // lastItemIndex += qntPerPage;
        _isLastPage = true;
      } else {
        // lastItemIndex += lastItemIndex + 10;
        qntPerPage = 10;
      }

      print('Item total: $lastItemIndex');

      lastItemIndex = lastItemIndex + qntPerPage;

      itensPerPage.clear();

      await Future.delayed(const Duration(milliseconds: 500))
          .then((value) => loadListData());

      setState(() {
        _isLoading = !_isLoading;
      });
    } else {
      ToastUtil.showToast(
          "Não há mais páginas para visualizar", Toast.LENGTH_SHORT);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary_0,
                ),
              ),
              Text(
                "Carregando Itens...",
                style: AppTextStyles.h6_regular,
              ),
            ],
          )
        : Column(
            children: [
              SizedBox(
                height: Get.height * .7,
                child: ListView.builder(
                  itemCount: itensPerPage.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PostListItemWidget(
                      item: itensPerPage.elementAt(index),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '$firstItemIndex - $lastItemIndex',
                    style: AppTextStyles.p_bold,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: InkWell(
                      onTap: () => onPreviousPage(),
                      child: Icon(
                        Icons.arrow_circle_left_rounded,
                        color: AppColors.primary_0,
                        size: 32,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => onNextPage(),
                    child: Icon(
                      Icons.arrow_circle_right_rounded,
                      color: AppColors.primary_0,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}
