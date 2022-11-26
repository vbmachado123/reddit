// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:reddit/page/home/widget/post_list_item.dart';
import 'package:reddit/service/reddit_service.dart';
import 'package:reddit/shared/widgets/filter_list_item_widget.dart';
import 'package:reddit/shared/widgets/input_widget.dart';
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

  bool isLoading = false;

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
      if (term.contains("r/")) {
        term.replaceAll("r/", "");
      } else if (term.contains("/r/")) {
        term.replaceAll("/r/", "");
      }

      var response = await RedditService().getContent(term);

      itens.clear();
      itens.addAll(response['data']['children']);
      print(response['data']);

      isLoading = false;
      for (int i = 0; i <= filters.length; i++) {
        if (filters.elementAt(i).label != term && i == filters.length) {
          filters.add(
            Filter(
              color: AppColors.correct,
              label: term,
              isSelected: true,
            ),
          );
        }
      }
    } catch (e) {
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
          bottom: 64,
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
                                reverse: false,
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
                                              filters.elementAt(index))
                                            element.isSelected = true;
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
                        SizedBox(
                          height: Get.height * .8,
                          child: ListView.builder(
                            itemCount: itens.length,
                            itemBuilder: (BuildContext context, int index) {
                              return PostListItemWidget(
                                item: itens.elementAt(index),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

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
