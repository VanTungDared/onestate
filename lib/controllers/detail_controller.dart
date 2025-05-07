import 'package:app_real_estate/api/api_client.dart';
import 'package:app_real_estate/models/ListingDetailModel.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  final apiClient = ApiClient();

  ListingDetailModel? listingDetail;
  RxInt countRender = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    String id = Get.arguments;
    await fetchListingDetail(id);
    countRender.value = countRender.value + 1;
  }

  var currentPage = 0.obs;

  void changePage(int index) {
    currentPage.value = index;
  }

  Future<void> fetchListingDetail(String id) async {
    try {
      final result = await apiClient.getListingDetail(id);

      if (result.containsKey('error')) {
        Get.snackbar('Lỗi', result['error']);
      } else {
        listingDetail = ListingDetailModel.fromJson(result);
        update(); // Cập nhật lại UI
      }
    } catch (e) {
      Get.snackbar('Lỗi', 'Không thể tải dữ liệu');
      print('fetchListingDetail error: $e');
    }
  }
}
