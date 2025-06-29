import 'package:get/get.dart';

import '../../../core/utils/app_translation.dart';
import '../../../data/datasources/dblocal/shared_preferences.dart';
import '../../routers/routerName.dart';

class AppController extends GetxController {

  static Future<void> init() async {
    await AppTranslations.loadTranslations();
    await SharedPreferenceApp.init();
  }

  String? get token => SharedPreferenceApp.handleGetString('accessToken');

  void handleNavigation() {
    if (token == null || token!.isEmpty) {
      Get.offAllNamed(RouterName.login);
    } else {
      Get.offAllNamed(RouterName.main);
    }
  }
}
