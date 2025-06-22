import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../core/utils/api/api_client.dart';
import '../../data/models/ListingModel.dart';
import '../../data/models/UserModel.dart';

class MyLikedController extends GetxController {
  final apiClient = ApiClient();
  final scrollController = ScrollController();
  late List<ListingModel>? dataListings; // thêm dòng này
  late UserModel? userModel; // thêm dòng này
  final double minHeight = 0.0;
  final double maxHeight = 46.0;
  final double maxWidthIcon = 46.0;

  RxDouble heightHeader = 46.0.obs;
  RxDouble opacityHeader = 1.0.obs;
  RxDouble widthIcon = 0.0.obs;
  RxDouble opacityIcon = 1.0.obs;
  RxInt countRender = 0.obs;

  @override
  void onInit() {
    super.onInit();
    dataListings = Get.arguments[0];
    userModel = Get.arguments[1];
    scrollController.addListener(() {
      double offset = scrollController.position.pixels;
      if (offset < 0) offset = 0;

      // Tính height header
      double newHeight = maxHeight - offset / 3;
      if (newHeight < minHeight) newHeight = minHeight;
      if (newHeight > maxHeight) newHeight = maxHeight;

      if (heightHeader.value != newHeight) {
        heightHeader.value = newHeight;

        // Tính widthIcon ngược chiều
        double ratio = (newHeight - minHeight) / (maxHeight - minHeight);
        double newWidthIcon = maxWidthIcon * (1 - ratio);

        if (widthIcon.value != newWidthIcon) {
          widthIcon.value = newWidthIcon;
        }

        // Tính opacityHeader (tỷ lệ thuận với heightHeader)
        double newOpacityHeader = ratio;
        if (opacityHeader.value != newOpacityHeader) {
          opacityHeader.value = newOpacityHeader;
        }

        // Tính opacityIcon (tỷ lệ thuận với widthIcon)
        double iconRatio = newWidthIcon / maxWidthIcon;
        if (opacityIcon.value != iconRatio) {
          opacityIcon.value = iconRatio;
        }
      }
    });
    countRender.value = countRender.value + 1;
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  String maskPhone(String? phone) {
    if (phone == null || phone.length < 7) return phone ?? '';
    return phone.replaceRange(7, phone.length, '*' * (phone.length - 7));
  }
}
