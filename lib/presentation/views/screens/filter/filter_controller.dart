import 'package:app_real_estate/core/utils/api/api_method.dart';
import 'package:app_real_estate/core/utils/notifier.dart';
import 'package:app_real_estate/data/models/UserModel.dart';
import 'package:app_real_estate/data/models/district.dart';
import 'package:app_real_estate/data/models/option.dart';
import 'package:app_real_estate/data/models/province.dart';
import 'package:app_real_estate/data/models/ward.dart';
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

  final ApiMethod apiMethod = ApiMethod();
  final Rxn<UserModel> userModel = Rxn<UserModel>();
  var provinceCode = ''.obs;
  var districtCode = ''.obs;
  var wardCode = ''.obs;

  final RxList<Province> provinces = <Province>[].obs;
  final RxList<District> districts = <District>[].obs;
  final RxList<Ward> wards = <Ward>[].obs;

  final controllerStreetName = TextEditingController();
  final controllerFullAddress = TextEditingController();

  final criteriaOptions = <OptionModel>[
    OptionModel(value: 'million_dollar', label: 'Triệu đô'),
    OptionModel(value: 'residential', label: 'Để ở'),
    OptionModel(value: 'investment', label: 'Lãi vốn (Rẻ)'),
    OptionModel(value: 'business', label: 'Để kinh doanh'),
    OptionModel(value: 'car_access', label: 'Hẻm ô tô'),
    OptionModel(value: 'stable_cash_flow', label: 'Đóng tiền ổn định'),
    OptionModel(value: 'owner_direct', label: 'Chính chủ'),
    OptionModel(value: 'need_sell_fast', label: 'Chủ cần bán gấp'),
  ];

  /// Selected options sẽ là list OptionModel luôn
  final selectedCriteria = <OptionModel>[].obs;

  RxSet<String> selectedItems = <String>{}.obs;

  @override
  void onInit() async {
    super.onInit();
    final data = Get.arguments;
    await handleFetchProvince();
    if (data["userModel"] != null && data["userModel"] is UserModel) {
      userModel.value = data["userModel"];
    } else {
      LoadingNotifier.showTopMessage("Không có thông tin tài khoản", false);
    }
  }

  handleFetchProvince() async {
    final dataFromServer = await apiMethod.get("provinces");
    if (dataFromServer.containsKey("error")) {
      LoadingNotifier.showTopMessage("${dataFromServer['error']}", false);
      return;
    }
    if (dataFromServer["data"] != null) {
      final provincesJson = dataFromServer["data"] as List;

      final provinces = provincesJson.map((e) => Province.fromJson(e)).toList();

      // Gán danh sách quận/huyện vào biến observable trong controller
      this.provinces.assignAll(provinces);
    }
  }

  handleSelectProvince(String? value, String id) async {
    provinceCode.value = id;
    final dataFromServer = await apiMethod.get("provinces/$id/districts");
    if (dataFromServer.containsKey("error")) {
      LoadingNotifier.showTopMessage("${dataFromServer['error']}", false);
      return;
    }
    if (dataFromServer["data"] != null) {
      final districtsJson = dataFromServer["data"] as List;

      final districts = districtsJson.map((e) => District.fromJson(e)).toList();

      // Gán danh sách quận/huyện vào biến observable trong controller
      this.districts.assignAll(districts);
    }
  }

  handleSelectDistrict(String? value, String id) async {
    districtCode.value = id;
    final dataFromServer = await apiMethod.get(
      "provinces/${provinceCode.value}/districts/$id/wards",
    );
    if (dataFromServer.containsKey("error")) {
      LoadingNotifier.showTopMessage("${dataFromServer['error']}", false);
      return;
    }
    if (dataFromServer["data"] != null) {
      final wardsJson = dataFromServer["data"] as List;

      final wards = wardsJson.map((e) => Ward.fromJson(e)).toList();

      // Gán danh sách quận/huyện vào biến observable trong controller
      this.wards.assignAll(wards);
    }
  }

  handleSelectWard(String? value, String id) async {
    wardCode.value = id;
  }

  @override
  void dispose() {
    controllerStreetName.dispose();
    controllerFullAddress.dispose();
    minActualAreaSqm.dispose();
    maxActualAreaSqm.dispose();
    maxNumberOfFloors.dispose();
    minFrontageMeters.dispose();
    super.dispose();
  }

  void fetchListings() async {
    final isValid = await validateForm();
    if (!isValid) return;
    isLoadingListing.value = true;
    final selectedTags = selectedCriteria.map((item) => item.value).toList();

    final result = await filterUseCase.call(
      page: currentPage.value,
      limit: pageSize,
      provinceCode: provinceCode.value,
      districtCode: districtCode.value,
      wardCode: wardCode.value,
      tags: selectedTags,
      streetName: controllerStreetName.text,
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
        Get.back(result: {"option": "success", "data": response.data});
      },
    );
  }

  void resetFilter() {
    Get.back(result: {"option": "clean"});
  }

  Future<bool> validateForm() async {
    if (provinceCode.value.isEmpty ||
        districtCode.value.isEmpty ||
        wardCode.value.isEmpty) {
      LoadingNotifier.showTopMessage(
        "Vui lòng chọn đầy đủ Tỉnh/Quận/Huyện/Xã",
        false,
      );
      return false;
    }
    if (controllerStreetName.text.trim().isEmpty) {
      LoadingNotifier.showTopMessage("Vui lòng nhập tên đường", false);
      return false;
    }
    if (controllerFullAddress.text.trim().isEmpty) {
      LoadingNotifier.showTopMessage("Vui lòng nhập địa chỉ chi tiết", false);
      return false;
    }

    return true;
  }
}
