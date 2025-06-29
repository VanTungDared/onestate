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
  }

  void fetchListings() async {
    isLoadingListing.value = true;
    final result = await getListingUseCase.call(1, 10, "sell");

    result.fold(
      (error) {
        print("Get listing failed: $error");
        isLoadingListing.value = false;
      },
      (listings) {
        dataListings.assignAll(listings);
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
