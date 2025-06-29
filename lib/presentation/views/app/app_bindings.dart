import 'package:get/get.dart';

import '../../../core/utils/api/api_client.dart';
import 'app_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DioClient>(DioClient(), permanent: true);
    Get.put<AppController>(AppController(), permanent: true);
  }
}
