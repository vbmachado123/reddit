import 'package:flutter/material.dart';

import '../../../core/core.dart';

class CommentListItemWidget extends StatelessWidget {
  final dynamic item;
  CommentListItemWidget({Key? key, required this.item}) : super(key: key);

  List<dynamic> replies = [];

  @override
  Widget build(BuildContext context) {
    // replies.addAll(item['data']['children']);
    print('Replies:  ${replies.length}');
    // var dateUtc = DateTime.parse(item['data']['created_utc'].toString());
// var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateUtc, true);
    // String
    // dateConverted = dateUtc;

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
        child: Column(children: [
          Row(
            children: [
              Text(
                item['data']['children'][0]['data']['author'],
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
                  item['data']['children'][0]['data']['body'],
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
                ' ${item['data']['children'][0]['data']['ups']} ',
                style: AppTextStyles.h7_bold,
              ),
              Icon(
                Icons.arrow_downward,
                size: 20,
                color: AppColors.grey_0,
              ),
            ],
          ),
        ]),
      ),
    );
  }
}


/**
 
 


 */