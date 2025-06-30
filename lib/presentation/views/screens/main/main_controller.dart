import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../core/utils/constants/asset_constants.dart';
import '../../../../core/utils/notifier.dart';
import '../../../../data/models/ListingModel.dart';
import '../../../../data/models/UserModel.dart';
import '../../../../domain/usecases/get_listing_use_case.dart';
import '../../../../domain/usecases/get_user_usecase.dart';
import '../../../routers/routerName.dart';

class MainController extends GetxController {
  final GetListingUseCase getListingUseCase;
  final GetUserUseCase getUserUseCase;
  final RxList<ListingModel> dataListings = <ListingModel>[].obs;

  final Rxn<UserModel> userModel = Rxn<UserModel>();

  MainController(this.getListingUseCase, this.getUserUseCase);

  PageController pageController = PageController(initialPage: 0);
  RxInt indexPage = 0.obs;
  final isLoadingMe = false.obs;
  final isLoadingListing = false.obs;
  final RxInt currentPage = 1.obs;
  final RxInt lastPage = 1.obs;
  final int pageSize = 10;
  final ScrollController scrollController = ScrollController();

  List<Map<String, dynamic>> bottomItems = [
    // {
    //   'icon': AssetConstant.homeIcon,
    //   'iconActive': AssetConstant.homeIconActive,
    //   'label': 'Trang chủ',
    // },
    {
      'icon': AssetConstant.shopIcon,
      'iconActive': AssetConstant.shopIconActive,
      'label': 'Thể loại',
    },
    {
      'icon': AssetConstant.profileIcon,
      'iconActive': AssetConstant.profileIconActive,
      'label': 'Tài khoản',
    },
  ];

  @override
  void onInit() async {
    super.onInit();

    fetchMe();
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

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void fetchListings() async {
    isLoadingListing.value = true;

    final result = await getListingUseCase.call(1, pageSize, "sell");

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

    final result = await getListingUseCase.call(nextPage, pageSize, "sell");

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

  void onPressCard({required String id}) {
    Get.toNamed(RouterName.detail, arguments: id);
  }

  void fetchMe() async {
    isLoadingMe.value = true;
    final userInfo = await getUserUseCase.call();
    userInfo.fold(
      (errorMessage) {
        LoadingNotifier.showTopMessage(errorMessage, false);
        isLoadingMe.value = false;
      },
      (data) {
        userModel.value = data;
        isLoadingMe.value = false;
      },
    );
  }
}
