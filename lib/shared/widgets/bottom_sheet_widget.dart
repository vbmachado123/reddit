import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reddit/core/app_colors.dart';
import 'package:reddit/core/app_text_styles.dart';

class BottomSheetWidget extends StatelessWidget {
  final Widget currentBody;
  final String title;
  final String subreddit;

  const BottomSheetWidget(
      {Key? key,
      required this.currentBody,
      required this.title,
      required this.subreddit})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
        color: AppColors.grey_02,
      ),
      padding: const EdgeInsets.symmetric(vertical: 16),
      // color: AppColors.white,
      child: Column(
        children: [
          Container(
            width: 29,
            height: 4,
            decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primary_0,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(4),
                color: AppColors.primary_0),
          ),
          SizedBox(
            height: 32,
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          subreddit,
                          style: AppTextStyles.h7_regular,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: AppTextStyles.p_bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  currentBody
                ],
              ) //Conteúdo do CARD
              ),
        ],
      ),
    );
  }
}
