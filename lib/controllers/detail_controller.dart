import 'package:app_real_estate/api/api_client.dart';
import 'package:app_real_estate/models/ListingDetailModel.dart';
import 'package:app_real_estate/utils/notifier.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  final apiClient = ApiClient();
  RxBool isLiked = false.obs;

  ListingDetailModel? listingDetail;
  RxInt countRender = 0.obs;

  String id = "";

  @override
  void onInit() async {
    super.onInit();
    id = Get.arguments;
    await fetchListingDetail();
    countRender.value = countRender.value + 1;
  }

  var currentPage = 0.obs;

  void changePage(int index) {
    currentPage.value = index;
  }

  Future<void> fetchListingDetail() async {
    try {
      final result = await apiClient.getListingDetail(id);

      if (result.containsKey('error')) {
        Get.snackbar('Lỗi', result['error']);
      } else {
        listingDetail = ListingDetailModel.fromJson(result);
        isLiked.value = listingDetail?.isLiked != null;
        update(); // Cập nhật lại UI
      }
    } catch (e) {
      Get.snackbar('Lỗi', 'Không thể tải dữ liệu');
      print('fetchListingDetail error: $e');
    }
  }

  Future<void> handleLikeListing() async {
    try {
      final result = await apiClient.likeListing(id);
      if (result.containsKey('error')) {
        LoadingNotifier.showTopMessage(result['error'], false);
      } else {
        LoadingNotifier.showTopMessage(
            isLiked.value
                ? "Đã bỏ thích thành công"
                : "Đã yêu thích thành công",
            true);
        // Cập nhật dữ liệu nếu cần
        isLiked.value = !isLiked.value;
      }
    } catch (e) {
      print('handleLikeListing error: $e');
      Get.snackbar('Lỗi', 'Đã xảy ra lỗi khi gọi API like');
    }
  }
}
