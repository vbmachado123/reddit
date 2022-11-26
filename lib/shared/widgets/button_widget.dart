import 'package:flutter/material.dart';
import 'package:reddit/core/app_text_styles.dart';
import 'package:reddit/core/core.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final TextStyle textStyle;
  final Color borderColor;

  final VoidCallback onTap;

  const ButtonWidget(
      {Key? key,
      required this.label,
      required this.backgroundColor,
      required this.textStyle,
      required this.borderColor,
      required this.onTap})
      : super(key: key);

  ButtonWidget.transparent({
    required String label,
    required VoidCallback onTap,
  })  : this.backgroundColor = Colors.transparent,
        this.textStyle = AppTextStyles.h6_bold,
        this.borderColor = Colors.transparent,
        this.onTap = onTap,
        this.label = label;

  ButtonWidget.primary({
    required String label,
    required VoidCallback onTap,
  })  : this.backgroundColor = AppColors.primary_0,
        this.textStyle = AppTextStyles.h6_bold_white,
        this.borderColor = AppColors.primary_0,
        this.onTap = onTap,
        this.label = label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          // AppShadows.shadow0
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 4),
      width: double.maxFinite,
      child: TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(backgroundColor),
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
            side: MaterialStateProperty.all(BorderSide(color: borderColor))),
        onPressed: onTap,
        child: Text(
          label,
          style: textStyle,
        ),
      ),
    );
  }
}
