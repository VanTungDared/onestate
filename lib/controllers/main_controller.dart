import 'package:app_real_estate/api/api_client.dart';
import 'package:app_real_estate/constants/asset_constants.dart';
import 'package:app_real_estate/models/ListingModel.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final apiClient = ApiClient();
  List<ListingModel> dataListings = [];
  RxInt countRender = 0.obs;

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
    Map<String, dynamic> result = await apiClient.getListings();
    dataListings = List<ListingModel>.from(
      (result["data"] as List).map((e) => ListingModel.fromJson(e)),
    );
    countRender.value = countRender.value + 1;
    print(result);
  }
}
