import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reddit/page/home/widget/comment_list_item.dart';
import 'package:reddit/service/reddit_service.dart';

import 'package:reddit/shared/widgets/bottom_sheet_widget.dart';

import '../../../core/core.dart';

class PostListItemWidget extends StatelessWidget {
  final dynamic item;
  const PostListItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var dateUtc = DateTime.parse(item['data']['created_utc'].toString());
// var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateUtc, true);
    // String
    // dateConverted = dateUtc;

    List itens = [];

    void showComments() async {
      var response = await RedditService()
          .getComments(item['data']['subreddit'], item['data']['id']);
      List temp = [];
      temp.addAll(response);

      print('Comentarios: ${temp.length}');

      temp.forEach((e) {
        if (e != temp.first) {
          itens.add(e);
          print('> Adicionado: ${e['data']['children'][0]['data']['author']}');
        }
      });

      showModalBottomSheet(
          context: context,
          builder: (context) => SingleChildScrollView(
                child: Container(
                  height: Get.height * .9,
                  color: Color(0xFF757575),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      color: Colors.transparent,
                    ),
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: BottomSheetWidget(
                      subreddit: item['data']['subreddit_name_prefixed'],
                      title: item['data']['title'],
                      currentBody: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Respostas",
                                style: AppTextStyles.h7_bold,
                              )
                            ],
                          ),
                          SizedBox(
                            height: Get.height * .4,
                            child: ListView.builder(
                              itemCount: itens.length,
                              itemBuilder: (BuildContext context, int index) {
                                return CommentListItemWidget(
                                  item: itens.elementAt(index),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
    }

    return InkWell(
      onTap: () => showComments(),
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 32,
                      width: 32,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(500),
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://www.redditstatic.com/avatars/defaults/v2/avatar_default_${Random().nextInt(7)}.png'),
                          //whatever image you can put here
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: 32,
                      width: 32,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(500),
                        image: DecorationImage(
                          image: NetworkImage('${item['data']['thumbnail']}'),
                          //whatever image you can put here
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  item['data']['author'],
                  style: AppTextStyles.h7_bold,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    item['data']['title'],
                    style: AppTextStyles.p_bold,
                  )),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.arrow_upward,
                  size: 20,
                  color: AppColors.grey_0,
                ),
                Text(
                  ' ${item['data']['ups']} ',
                  style: AppTextStyles.h7_bold,
                ),
                Icon(
                  Icons.arrow_downward,
                  size: 20,
                  color: AppColors.grey_0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
