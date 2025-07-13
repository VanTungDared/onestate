import 'package:app_real_estate/data/models/provinces_model.dart';
import 'package:app_real_estate/domain/usecases/get_district_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../domain/usecases/get_ward_use_case.dart';

class FilterController extends GetxController {
  final GetDistrictUseCase getDistrictUseCase;
  final GetWardUseCase getWardUseCase;

  FilterController(this.getDistrictUseCase, this.getWardUseCase);

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

  final List<String> options = [
    'Triệu đô',
    'Để ở',
    'Lãi vốn (Rẻ)',
    'Để kink doanh',
    'Hẻm ô tô',
    'Đóng tiền ổn định',
    'Chính chủ',
    'Chủ cần bán gấp',
  ];

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
}
