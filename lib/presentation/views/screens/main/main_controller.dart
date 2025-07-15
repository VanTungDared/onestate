import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/constants/asset_constants.dart';
import '../../../../core/utils/notifier.dart';
import '../../../../data/models/ListingModel.dart';
import '../../../../data/models/UserModel.dart';
import '../../../../domain/entities/type_house.dart';
import '../../../../domain/usecases/filter_apartment_use_case.dart';
import '../../../../domain/usecases/get_listing_use_case.dart';
import '../../../../domain/usecases/get_user_usecase.dart';
import '../../../routers/routerName.dart';

enum SortOption {
  newest,
  priceLowToHigh,
  priceHighToLow,
  areaSmallToLarge,
  areaLargeToSmall,
}

class MainController extends GetxController {
  final GetListingUseCase getListingUseCase;
  final GetUserUseCase getUserUseCase;
  final FilterApartmentUseCase filterApartmentUseCase;
  final RxList<ListingModel> dataListings = <ListingModel>[].obs;

  final Rxn<UserModel> userModel = Rxn<UserModel>();

  MainController(
    this.getListingUseCase,
    this.getUserUseCase,
    this.filterApartmentUseCase,
  );

  PageController pageController = PageController(initialPage: 0);
  RxInt indexPage = 0.obs;
  final isLoadingMe = false.obs;
  final isLoadingListing = false.obs;
  final RxInt currentPage = 1.obs;
  final RxInt lastPage = 1.obs;
  final int pageSize = 10;
  final ScrollController scrollController = ScrollController();
  final Rx<SortOption> selectedSortOption = SortOption.newest.obs;
  final RxInt minPrice = 0.obs;
  final RxInt maxPrice = 0.obs;

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

  final List<HouseType> typeHouse = [
    HouseType(label: 'Chung cư', icon: Icons.apartment, value: 'apartment'),
    HouseType(
      label: 'Chung cư mini',
      icon: Icons.home_work,
      value: 'mini_apartment',
    ),
    HouseType(
      label: 'Lãi vốn (Rẻ)',
      icon: Icons.attach_money,
      value: 'cashflow',
    ),
    HouseType(label: 'Nhà phố', icon: Icons.house, value: 'house'),
    HouseType(
      label: 'Nhà ngõ',
      icon: Icons.location_city,
      value: 'alley_house',
    ),
    HouseType(label: 'Biệt thự', icon: Icons.villa, value: 'villa'),
    HouseType(label: 'Đất nền', icon: Icons.terrain, value: 'land'),
    HouseType(label: 'Văn phòng', icon: Icons.business, value: 'office'),
    HouseType(label: 'Đóng tiền', icon: Icons.payments, value: 'cashflow'),
  ];

  RxSet<String> selectedTypeHouse = <String>{}.obs;

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

  void sortListings() {
    final current = selectedSortOption.value;

    final sorted = [...dataListings];

    switch (current) {
      case SortOption.newest:
        sorted.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case SortOption.priceLowToHigh:
        sorted.sort(
          (a, b) => a.listingPriceVndSell.compareTo(b.listingPriceVndSell),
        );
        break;
      case SortOption.priceHighToLow:
        sorted.sort(
          (a, b) => b.listingPriceVndSell.compareTo(a.listingPriceVndSell),
        );
        break;
      case SortOption.areaSmallToLarge:
        sorted.sort((a, b) => a.actualAreaSqm.compareTo(b.actualAreaSqm));
        break;
      case SortOption.areaLargeToSmall:
        sorted.sort((a, b) => b.actualAreaSqm.compareTo(a.actualAreaSqm));
        break;
    }

    dataListings.assignAll(sorted);
  }

  void goToFilterScreen() {
    Get.toNamed(RouterName.filter)?.then((value) {
      if (value != null) {
        dataListings.clear();
        dataListings.addAll(value);
      }
    });
  }

  void filterByTypeHouse() async {
    isLoadingListing.value = true;
    final result = await filterApartmentUseCase.call(
      page: 1,
      limit: 10,
      listingType: 'sell',
      propertyTypes: selectedTypeHouse.toList(),
      sort: 'default',
      minPrice: minPrice.value == 0 ? null : minPrice.value,
      maxPrice: maxPrice.value == 0 ? null : maxPrice.value,
    );

    result.fold(
      (error) {
        print("Get listing failed: $error");
        isLoadingListing.value = false;
      },
      (response) {
        dataListings.clear();
        dataListings.assignAll(response.data);
        isLoadingListing.value = false;
        Get.back();
      },
    );
  }

  void filterByTypePrice() async {
    isLoadingListing.value = true;
    final result = await filterApartmentUseCase.call(
      page: 1,
      limit: 10,
      listingType: 'sell',
      propertyTypes:
          selectedTypeHouse.toList().isEmpty
              ? null
              : selectedTypeHouse.toList(),
      sort: 'default',
      minPrice: minPrice.value,
      maxPrice: maxPrice.value,
    );

    result.fold(
      (error) {
        print("Get listing failed: $error");
        isLoadingListing.value = false;
      },
      (response) {
        dataListings.clear();
        dataListings.assignAll(response.data);
        isLoadingListing.value = false;
        Get.back();
      },
    );
  }

  void resetTypeHouse() {
    selectedTypeHouse.clear();
    Get.back();
  }

  void resetTypePrice() {
    minPrice.value = 0;
    maxPrice.value = 0;
    Get.back();
  }
}
