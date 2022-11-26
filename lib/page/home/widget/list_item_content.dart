import 'package:flutter/material.dart';

import '../../../core/core.dart';

class ListItemContent extends StatelessWidget {
  final dynamic item;
  const ListItemContent({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
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
                item['data']['body'],
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
    );
  }
}
