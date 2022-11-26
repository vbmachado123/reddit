import 'package:fluttertoast/fluttertoast.dart';

import '../core/core.dart';

class ToastUtil {
  static showToast(String mensage, toastLength) {
    Fluttertoast.showToast(
      msg: mensage,
      toastLength: toastLength,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.white,
      textColor: AppColors.black,
    );
  }
}
