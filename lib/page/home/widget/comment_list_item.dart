import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';

class CommentListItemWidget extends StatelessWidget {
  final dynamic item;
  CommentListItemWidget({Key? key, required this.item}) : super(key: key);

  List<dynamic> replies = [];

  @override
  Widget build(BuildContext context) {
    replies.addAll(item['data']['children']);
    print('Replies:  ${replies.length}');

/**
 * A lista de comentários e respostas para o comentário é teoricamente infinita;
 Esse widget precisa ser dinamico o suficiente para receber essa 
 estrutura de dados e exibir da maneira correta
 */
    return InkWell(
      onTap: () => {},
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
        child: SizedBox(
          height: 250,
          child: ListView.builder(
            itemCount: replies.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(children: [
                  Row(
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
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        replies.elementAt(index)['data']['author'],
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
                          replies.elementAt(index)['data']['body'],
                          style: AppTextStyles.p_regular,
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
                        ' ${replies.elementAt(index)['data']['ups']} ',
                        style: AppTextStyles.h7_bold,
                      ),
                      Icon(
                        Icons.arrow_downward,
                        size: 20,
                        color: AppColors.grey_0,
                      ),
                    ],
                  ),
                  Container(
                    width: double.maxFinite,
                    height: 1,
                    decoration: BoxDecoration(
                      color: AppColors.grey_01,
                    ),
                  ),
                ]),
              );
            },
          ),
        ),
      ),
    );
  }
}
