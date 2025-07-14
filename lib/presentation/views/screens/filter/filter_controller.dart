import 'package:app_real_estate/data/models/provinces_model.dart';
import 'package:app_real_estate/domain/usecases/get_district_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/models/ListingModel.dart';
import '../../../../domain/usecases/filter_usecase.dart';
import '../../../../domain/usecases/get_ward_use_case.dart';

class FilterController extends GetxController {
  final GetDistrictUseCase getDistrictUseCase;
  final GetWardUseCase getWardUseCase;
  final FilterUseCase filterUseCase;

  FilterController(
    this.getDistrictUseCase,
    this.getWardUseCase,
    this.filterUseCase,
  );

  RxBool isLoading = false.obs;
  RxBool isSelectSell = true.obs;
  RxList<ProvincesModel> districts = <ProvincesModel>[].obs;
  RxList<ProvincesModel> wards = <ProvincesModel>[].obs;

  final Map<String, String> listCity = {"01": "Hà Nội", "79": "Hồ Chí Minh"};

  RxString selectedCityId = "".obs;
  RxString selectedDistrictCode = "".obs;
  RxString selectedWardId = "".obs;
  TextEditingController nameStress = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController minActualAreaSqm = TextEditingController();
  TextEditingController maxActualAreaSqm = TextEditingController();
  TextEditingController minNumberOfFloors = TextEditingController();
  TextEditingController maxNumberOfFloors = TextEditingController();
  TextEditingController minFrontageMeters = TextEditingController();
  TextEditingController maxFrontageMeters = TextEditingController();
  final isLoadingListing = false.obs;
  final RxList<ListingModel> dataListings = <ListingModel>[].obs;
  final RxInt currentPage = 1.obs;
  final RxInt lastPage = 1.obs;
  final int pageSize = 10;

  final List<String> options = [
    'Triệu đô',
    'Để ở',
    'Lãi vốn (Rẻ)',
    'Để kinh doanh',
    'Hẻm ô tô',
    'Đóng tiền ổn định',
    'Chính chủ',
    'Chủ cần bán gấp',
  ];

   Map<String, String> tagMapping = {
    'Triệu đô': 'million_dollar',
    'Để ở': 'residential',
    'Lãi vốn (Rẻ)': 'investment',
    'Để kinh doanh': 'business',
    'Hẻm ô tô': 'car_access',
    'Đóng tiền ổn định': 'stable_cash_flow',
    'Chính chủ': 'owner_direct',
    'Chủ cần bán gấp': 'need_sell_fast',
  };

  RxSet<String> selectedItems = <String>{}.obs;

  @override
  void dispose() {
    nameStress.dispose();
    address.dispose();
    minActualAreaSqm.dispose();
    maxActualAreaSqm.dispose();
    maxNumberOfFloors.dispose();
    minFrontageMeters.dispose();
    super.dispose();
  }

  void getDistricts() async {
    isLoading.value = true;

    final result = await getDistrictUseCase.call(
      province: selectedCityId.value,
    );

    result.fold(
      (error) {
        isLoading.value = false;
      },
      (response) {
        districts.assignAll(response);
        isLoading.value = false;
      },
    );
  }

  void getWards() async {
    isLoading.value = true;

    final result = await getWardUseCase.call(
      codeDistrict: selectedCityId.value,
      codeWard: selectedDistrictCode.value,
    );

    result.fold(
      (error) {
        isLoading.value = false;
      },
      (response) {
        wards.assignAll(response);
        isLoading.value = false;
      },
    );
  }

  void fetchListings() async {
    isLoadingListing.value = true;
    final selectedTags = selectedItems
        .where((item) => tagMapping.containsKey(item))
        .map((item) => tagMapping[item]!)
        .toList();

    final result = await filterUseCase.call(
      page: currentPage.value,
      limit: pageSize,
      provinceCode: selectedCityId.value,
      districtCode: selectedDistrictCode.value,
      wardCode: selectedWardId.value,
      tags: selectedTags,
      streetName: nameStress.text,
      listingType: isSelectSell.value ? 'sell' : 'rent',
      sort: 'default',
      minActualAreaSqm: double.tryParse(minActualAreaSqm.text) ?? 0,
      maxActualAreaSqm: double.tryParse(maxActualAreaSqm.text) ?? 0,
      minNumberOfFloors: double.tryParse(minNumberOfFloors.text) ?? 0,
      maxNumberOfFloors: double.tryParse(maxNumberOfFloors.text) ?? 0,
      minFrontageMeters: double.tryParse(minFrontageMeters.text) ?? 0,
      maxFrontageMeters: double.tryParse(maxFrontageMeters.text) ?? 0,
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
        print("Get more listings successfully");
        Get.back(result: response.data);
      },
    );
  }
}
