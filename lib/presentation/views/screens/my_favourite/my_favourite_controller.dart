import 'package:app_real_estate/domain/usecases/get_listing_favourite_use_case.dart';
import 'package:app_real_estate/presentation/routers/routerName.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../data/models/ListingModel.dart';

class MyFavouriteController extends GetxController {
  MyFavouriteController(this.getListingFavouriteUseCase);
  final GetListingFavouriteUseCase getListingFavouriteUseCase;
  final scrollController = ScrollController();
  final RxList<ListingModel> dataListings = <ListingModel>[].obs;
  final double minHeight = 0.0;
  final double maxHeight = 46.0;
  final double maxWidthIcon = 46.0;

  RxDouble heightHeader = 46.0.obs;
  RxDouble opacityHeader = 1.0.obs;
  RxDouble widthIcon = 0.0.obs;
  RxDouble opacityIcon = 1.0.obs;
  final int pageSize = 10;
  final isLoadingListing = false.obs;
  final RxInt currentPage = 1.obs;
  final RxInt lastPage = 1.obs;

  @override
  void onInit() {
    super.onInit();
    fetchListings();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200 &&
          !isLoadingListing.value &&
          currentPage.value < lastPage.value) {
        fetchMoreListings();
      }
    });
  }

  void onPressCard({required String id}) {
    Get.toNamed(RouterName.detail, arguments: id);
  }

  void fetchListings() async {
    isLoadingListing.value = true;

    final result = await getListingFavouriteUseCase.call(1, pageSize, "sell");

    result.fold(
      (error) {
        print("Get listing failed: $error");
        isLoadingListing.value = false;
      },
      (response) {
        dataListings.assignAll(response.data);
        currentPage.value = response.currentPage;
        lastPage.value = response.lastPage;
        isLoadingListing.value = false;
      },
    );
  }

  void fetchMoreListings() async {
    isLoadingListing.value = true;
    final nextPage = currentPage.value + 1;
    final result = await getListingFavouriteUseCase.call(
      nextPage,
      pageSize,
      "sell",
    );
    result.fold(
      (error) {
        print("Get more listings failed: $error");
        isLoadingListing.value = false;
      },
      (response) {
        dataListings.addAll(response.data);
        currentPage.value = response.currentPage;
        lastPage.value = response.lastPage;
        isLoadingListing.value = false;
      },
    );
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
