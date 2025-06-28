import 'package:app_real_estate/domain/usecases/get_listing_by_id_use_case.dart';
import 'package:get/get.dart';

import '../../../../core/utils/notifier.dart';
import '../../../../data/models/listing_detail_model.dart';

class DetailController extends GetxController {
  RxBool isLiked = false.obs;
  final GetListingByIdUseCase getListingByIdUseCase;
  final Rxn<ListingDetailModel> listingDetail = Rxn<ListingDetailModel>();

  DetailController(this.getListingByIdUseCase);

  final isLoading = false.obs;
  String id = "";

  @override
  void onInit() async {
    super.onInit();
    id = Get.arguments;
    await fetchListingDetail(id: id);
  }

  var currentPage = 0.obs;

  void changePage(int index) {
    currentPage.value = index;
  }

  Future<void> fetchListingDetail({required String id}) async {
    isLoading.value = true;

    final result = await getListingByIdUseCase.call(id: id);

    result.fold(
      (errorMessage) {
        LoadingNotifier.showTopMessage(errorMessage, false);
        isLoading.value = false;
      },
      (data) async {
        listingDetail.value = data;
        isLoading.value = false;
      },
    );
  }

  Future<void> handleLikeListing() async {
    // try {
    //   final result = await apiClient.likeListing(id);
    //   if (result.containsKey('error')) {
    //     LoadingNotifier.showTopMessage(result['error'], false);
    //   } else {
    //     LoadingNotifier.showTopMessage(
    //       isLiked.value ? "Đã bỏ thích thành công" : "Đã yêu thích thành công",
    //       true,
    //     );
    //     // Cập nhật dữ liệu nếu cần
    //     isLiked.value = !isLiked.value;
    //   }
    // } catch (e) {
    //   print('handleLikeListing error: $e');
    //   Get.snackbar('Lỗi', 'Đã xảy ra lỗi khi gọi API like');
    // }
  }
}
