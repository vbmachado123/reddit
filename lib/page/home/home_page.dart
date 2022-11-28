import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:reddit/page/home/widget/post_list_item.dart';
import 'package:reddit/service/reddit_service.dart';
import 'package:reddit/shared/widgets/filter_list_item_widget.dart';
import 'package:reddit/shared/widgets/input_widget.dart';
import 'package:reddit/shared/widgets/pagination_widget.dart';
import 'package:reddit/util/toast_util.dart';

import '../../core/core.dart';
import '../../model/filter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = new TextEditingController();
  List itens = [];

  bool isLoading = false, reverseList = false;

  @override
  void initState() {
    filters.elementAt(0).isSelected = true;
    searchTerm(filters.elementAt(0).label);
    super.initState();
  }

  void searchTerm(String term) async {
    print('> Pesquisando...');

    setState(() {
      isLoading = true;
    });

    try {
      // Caso o usuário insira os prefixos para pesquisa,
      //remover antes de enviar a req
      if (term.contains("r/")) {
        term.replaceAll("r/", "");
      } else if (term.contains("/r/")) {
        term.replaceAll("/r/", "");
      }
      // Caso o texto digitado tenha espaço
      if (term.contains("\\s")) {
        term.replaceAll("\\s", "");
      }

      // Aguardando requisição
      var response = await RedditService().getContent(term);

      itens.clear();
      itens.addAll(response['data']['children']);
      print(
          '> Tamanho da lista:  Total: ${itens.length} | Paginas: ${itens.length % 10}');

      print(response['data']);

      isLoading = false;

      // Verificando se o termo pesquisado já
      //consta na lista de filtros, caso não, ele adiciona
      bool addOnFilterList = true;
      if (itens.length >= 1) {
        filters.forEach((element) {
          element.isSelected = false;
          if (term == element.label) {
            addOnFilterList = false;
            element.isSelected = true;
          }
        });

        if (addOnFilterList) {
          reverseList = true;
          filters.add(
            Filter(
              color: AppColors.correct,
              label: term,
              isSelected: true,
            ),
          );
        }
      } else {
        ToastUtil.showToast(
          "Nenhum resultado encontrado! verifique se digitou corretamente",
          Toast.LENGTH_SHORT,
        );
      }
    } catch (e) {
      print('Erro: $e');
      ToastUtil.showToast(
        "Termo não encontrado! verifique se digitou corretamente",
        Toast.LENGTH_SHORT,
      );
      isLoading = false;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey_02,
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 48,
          top: 32,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InputWidget.icon(
                label: "",
                hint: "Pesquisar por subreddit",
                controller: searchController,
                icon: IconButton(
                  onPressed: () => searchTerm(searchController.text),
                  icon: Icon(
                    Icons.search,
                    size: 28,
                    color: AppColors.primary_0,
                  ),
                ),
              ),
              isLoading
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary_0,
                          ),
                        ),
                        Text(
                          "Pesquisando Termo...",
                          style: AppTextStyles.h6_regular,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Resultados de: ",
                              style: AppTextStyles.p_bold,
                            ),
                            SizedBox(
                              height: 32,
                              width: Get.width * .6,
                              child: ListView.builder(
                                reverse: reverseList,
                                scrollDirection: Axis.horizontal,
                                itemCount: filters.length,
                                cacheExtent: 400,
                                itemBuilder: (BuildContext context, int index) {
                                  return FilterListItemWidget(
                                      filter: filters.elementAt(index),
                                      onTap: () {
                                        filters.forEach((element) {
                                          element.isSelected = false;

                                          if (element ==
                                              filters.elementAt(index)) {
                                            element.isSelected = true;
                                          }
                                          setState(() {});
                                        });

                                        searchTerm(
                                          filters.elementAt(index).label,
                                        );
                                      });
                                },
                              ),
                            ),
                          ],
                        ),
                        PaginationWidget(
                          itens: itens,
                        )
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

// Recomendações de comunidades, conforme o usuario for pesquisando,
//novos itens serão adicionados aqui
  List<Filter> filters = [
    Filter(
      color: AppColors.primary1,
      label: "androiddev",
      isSelected: false,
    ),
    Filter(
      color: AppColors.red_0,
      label: "aplicativos",
      isSelected: false,
    ),
    Filter(
      color: AppColors.green_water,
      label: "FlutterDev",
      isSelected: false,
    ),
    Filter(
      color: AppColors.orange,
      label: "learnjavascript",
      isSelected: false,
    ),
  ];
}
