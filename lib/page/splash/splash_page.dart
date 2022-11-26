import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:reddit/page/home/home_page.dart';

import '../../core/core.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then(
      (value) => Get.offAll(HomePage()),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey_02,
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Center(
          child: Lottie.network(
            "https://assets2.lottiefiles.com/packages/lf20_zoe5oujy.json",
            height: 120,
          ),
        ),
      ),
    );
  }
}
