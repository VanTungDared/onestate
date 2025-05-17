import 'package:app_real_estate/api/api_client.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final apiClient = ApiClient();
  final scrollController = ScrollController();

  // Đây bạn có thể quản lý danh sách item từ API hoặc local list
  RxList<Map<String, dynamic>> items =
      [
        {
          'image':
              'https://images.unsplash.com/photo-1600585154340-be6161a56a0c',
          'label':
              '69.9 Dương Khuê 49 4 4 11.3 tỷ Cầu Giấy 9-15 Tỷ HĐ Đầu chủ Phạm Bình Minh 0966688094 .HH 3% giá bán thực tế nguồn Đối tác Phạm Bình Minh',
          'phone': '0966688094',
          'price': '11.3 tỷ',
          'owner': 'Phạm Bình Minh',
          'area': '49 m2',
          'isFavorite': false.obs,
        },
        // Thêm item khác nếu muốn
      ].obs;

  final double minHeight = 0.0;
  final double maxHeight = 46.0;
  final double maxWidthIcon = 46.0;

  RxDouble heightHeader = 46.0.obs;
  RxDouble opacityHeader = 1.0.obs;
  RxDouble widthIcon = 0.0.obs;
  RxDouble opacityIcon = 1.0.obs;

  @override
  void onInit() {
    super.onInit();

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
