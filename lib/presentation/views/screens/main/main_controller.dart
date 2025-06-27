import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../core/utils/constants/asset_constants.dart';
import '../../../../data/models/ListingModel.dart';
import '../../../../data/models/UserModel.dart';
import '../../../../domain/usecases/get_listing_use_case.dart';
import '../../../routers/routerName.dart';

class MainController extends GetxController {
  final GetListingUseCase getListingUseCase;
  final RxList<ListingModel> dataListings = <ListingModel>[].obs;

  late UserModel userModel;

  MainController(this.getListingUseCase);

  PageController pageController = PageController(initialPage: 0);
  RxInt indexPage = 0.obs;
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
    userModel = Get.arguments;
    fetchListings();
  }

  void fetchListings() async {
    final result = await getListingUseCase.call(1, 10, "sell");

    result.fold(
      (error) {
        print("Get listing failed: $error");
      },
      (listings) {
        dataListings.assignAll(listings);
      },
    );
  }

  void onPressCard() {
    Get.toNamed(RouterName.detail);
  }
}
