import 'package:get/get.dart';

class ProfileController extends GetxController {
  final username = 'Phạm Bình Minh';
  final bio = 'Chuyên viên bất động sản uy tín, tận tâm.';
  final avatarUrl = 'https://i.pravatar.cc/150?img=12';

  List<Map<String, dynamic>> posts = [
    {
      'image': 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c',
      'label': 'Nhà phố Quận 7, 50m², giá 5.5 tỷ',
      'price': '5.5 tỷ',
      'owner': 'Phạm Bình Minh',
      'area': '50 m²',
      'isFavorite': false.obs,
    },
    // {
    //   'image': 'https://images.unsplash.com/photo-1599423300746-b62533397364',
    //   'label': 'Biệt thự nghỉ dưỡng Vũng Tàu, 120m², 12 tỷ',
    //   'price': '12 tỷ',
    //   'owner': 'Phạm Bình Minh',
    //   'area': '120 m²',
    //   'isFavorite': true.obs,
    // },
  ];
}
