// import 'package:get/get.dart';
// // ignore: depend_on_referenced_packages
// import 'package:logger/logger.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

class Log {
  static final logger = Logger(printer: PrettyPrinter());
  static final loggerNoStack = Logger(printer: PrettyPrinter(methodCount: 0));
  static showDefaultDialogSimple({String title = "", String middleText = ""}) {
    Get.defaultDialog(title: title, middleText: middleText);
  }

  showSnackbarSimple(String title, String message) {
    Get.showSnackbar(GetSnackBar(title: title, message: message));
  }

  static showLoggerMapList(data) {
    loggerNoStack.t(data);
  }

  static showLoggerInfo(data) {
    loggerNoStack.i(data);
  }

  static showLoggerD(data) {
    logger.d(data);
  }
}
