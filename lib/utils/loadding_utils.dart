import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loadding {
  static bool isLoadding = false;
  static loaddingDefalult(isLoad) {
    if (isLoad && !isLoadding) {
      isLoadding = isLoad;
      showDialog(
          barrierDismissible: false,
          context: Get.context!,
          builder: (context) => Center(child: CircularProgressIndicator()));
    } else if (!isLoad) {
      if (isLoadding) {
        isLoadding = isLoad;
        Get.back();
      }
    }
  }
}
