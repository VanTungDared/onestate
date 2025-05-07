import 'package:app_real_estate/api/api_client.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final apiClient = ApiClient();

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
}
