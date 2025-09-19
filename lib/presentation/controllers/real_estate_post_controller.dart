import 'dart:async';

import 'package:app_real_estate/core/utils/api/api_method.dart';
import 'package:app_real_estate/core/utils/notifier.dart';
import 'package:app_real_estate/data/models/UserModel.dart';
import 'package:app_real_estate/data/models/district.dart';
import 'package:app_real_estate/data/models/option.dart';
import 'package:app_real_estate/data/models/ward.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class RealEstatePostController extends GetxController {
  final controllerTitle = TextEditingController();
  final controllerDescription = TextEditingController();
  final controllerOwnerName = TextEditingController();
  final controllerOwnerPhoneNumber = TextEditingController();
  final controllerIdCard = TextEditingController();
  final controllerLegalAreaSqm = TextEditingController();
  final controllerActualAreaSqm = TextEditingController();
  final controllerFrontageMeters = TextEditingController();
  final controllerWidthMeters = TextEditingController();
  final controllerNumberOfFloors = TextEditingController();
  final controllerNumberOfRooms = TextEditingController();
  final controllerNumberOfBathrooms = TextEditingController();
  final controllerNumberOfBalconies = TextEditingController();

  var provinceCode = ''.obs;
  var districtCode = ''.obs;
  var wardCode = ''.obs;

  final controllerStreetName = TextEditingController();
  final controllerFullAddress = TextEditingController();
  final controllerLandCertificateCode = TextEditingController();
  final controllerListingPriceVndSell = TextEditingController();
  final controllerCommissionRatePercent = TextEditingController();
  final controllerCommissionAmountVnd = TextEditingController();

  var isMapInteracting = false.obs;

  List<XFile> images = [];
  List<XFile> imagesLegal = [];

  var renderImage = 0.obs;
  var renderImageLegal = 0.obs;
  var legalDocumentsSeri = ''.obs;

  var mapLatLng = Rxn<LatLng>(); // ví dụ: LatLng(10.762622, 106.660172)

  final ApiMethod apiMethod = ApiMethod();

  final RxList<District> districts = <District>[].obs;
  final RxList<Ward> wards = <Ward>[].obs;

  final propertyTypes = <OptionModel>[
    OptionModel(value: 'apartment', label: 'Chung cư'),
    OptionModel(value: 'mini_apartment', label: 'Chung cư mini'),
    OptionModel(value: 'house', label: 'Nhà phố'),
    OptionModel(value: 'alley_house', label: 'Nhà ngõ'),
    OptionModel(value: 'villa', label: 'Biệt thự'),
    OptionModel(value: 'land', label: 'Đất nền'),
    OptionModel(value: 'office', label: 'Văn phòng'),
    OptionModel(value: 'cashflow', label: 'Dòng tiền'),
  ];

  var propertyType = Rx<OptionModel?>(null);

  final listingTypes = <OptionModel>[
    OptionModel(value: 'sell', label: 'Bán'),
    OptionModel(value: 'rent', label: 'Cho thuê'),
  ];

  var listingType = Rx<OptionModel?>(null);

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

  final legalStatusOptions = <OptionModel>[
    OptionModel(value: 'has_certificate', label: 'Nhà có sổ'),
    OptionModel(value: 'has_contract', label: 'Nhà có hợp đồng'),
    OptionModel(value: 'no_certificate', label: 'Nhà không sổ'),
  ];

  // mặc định chưa chọn
  var legalStatus = Rx<OptionModel?>(null);

  final Rxn<UserModel> userModel = Rxn<UserModel>();

  final mapController = Completer<GoogleMapController>();

  @override
  void onInit() async {
    super.onInit();
    propertyType.value = propertyTypes.firstWhere((e) => e.value == 'land');
    listingType.value = listingTypes.firstWhere((e) => e.value == 'sell');
    final data = Get.arguments;
    if (data["userModel"] != null && data["userModel"] is UserModel) {
      userModel.value = data["userModel"];
    } else {
      LoadingNotifier.showTopMessage("Không có thông tin tài khoản", false);
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

  Future<void> pickMultipleImages() async {
    final List<XFile>? pickedFiles = await ImagePicker().pickMultiImage(
      imageQuality: 80, // giảm dung lượng ảnh nếu cần
    );

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      images = pickedFiles;
      renderImage.value = renderImage.value + 1;
      // Nếu muốn upload nhiều ảnh lên server, xử lý danh sách _images
    }
  }

  Future<void> pickMultipleImagesLegal() async {
    final List<XFile>? pickedFiles = await ImagePicker().pickMultiImage(
      imageQuality: 80, // giảm dung lượng ảnh nếu cần
    );

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      imagesLegal = pickedFiles;
      renderImageLegal.value = renderImageLegal.value + 1;
      // Nếu muốn upload nhiều ảnh lên server, xử lý danh sách _images
    }
  }

  void removeImage(XFile image) {
    images.remove(image);
    renderImage.value = renderImage.value + 1;
  }

  void removeImageLegal(XFile image) {
    imagesLegal.remove(image);
    renderImageLegal.value = renderImageLegal.value + 1;
  }

  @override
  void onClose() {
    // Giải phóng tất cả TextEditingController
    controllerTitle.dispose();
    controllerDescription.dispose();
    controllerOwnerName.dispose();
    controllerOwnerPhoneNumber.dispose();
    controllerIdCard.dispose();
    controllerLegalAreaSqm.dispose();
    controllerActualAreaSqm.dispose();
    controllerFrontageMeters.dispose();
    controllerWidthMeters.dispose();
    controllerNumberOfFloors.dispose();
    controllerNumberOfRooms.dispose();
    controllerNumberOfBathrooms.dispose();
    controllerNumberOfBalconies.dispose();
    controllerStreetName.dispose();
    controllerFullAddress.dispose();
    controllerLandCertificateCode.dispose();
    controllerListingPriceVndSell.dispose();
    controllerCommissionRatePercent.dispose();
    controllerCommissionAmountVnd.dispose();

    // Clear dữ liệu observable
    provinceCode.value = '';
    districtCode.value = '';
    wardCode.value = '';
    selectedCriteria.clear();
    districts.clear();
    wards.clear();
    userModel.value = null;

    // Clear hình ảnh
    images.clear();
    imagesLegal.clear();

    // Reset render state
    renderImage.value = 0;
    renderImageLegal.value = 0;
    legalDocumentsSeri.value = '';
    mapLatLng.value = null;

    super.onClose();
  }

  Future<bool> validateForm() async {
    if (controllerTitle.text.trim().isEmpty) {
      LoadingNotifier.showTopMessage("Vui lòng nhập tiêu đề", false);
      return false;
    }
    if (controllerDescription.text.trim().isEmpty) {
      LoadingNotifier.showTopMessage("Vui lòng nhập mô tả", false);
      return false;
    }
    if (controllerOwnerName.text.trim().isEmpty) {
      LoadingNotifier.showTopMessage("Vui lòng nhập tên chủ sở hữu", false);
      return false;
    }
    if (controllerOwnerPhoneNumber.text.trim().isEmpty) {
      LoadingNotifier.showTopMessage("Vui lòng nhập số điện thoại", false);
      return false;
    }
    if (provinceCode.value.isEmpty ||
        districtCode.value.isEmpty ||
        wardCode.value.isEmpty) {
      LoadingNotifier.showTopMessage(
        "Vui lòng chọn đầy đủ Tỉnh/Quận/Huyện/Xã",
        false,
      );
      return false;
    }
    if (controllerListingPriceVndSell.text.trim().isEmpty) {
      LoadingNotifier.showTopMessage("Vui lòng nhập giá bán", false);
      return false;
    }

    return true;
  }

  handleConfirm() async {
    try {
      final isValid = await validateForm();
      if (!isValid) return;

      final tags = selectedCriteria.map((e) => e.value).toList();

      final body = {
        "title": controllerTitle.text.trim(),
        "listingType": listingType.value, // sell | rent
        "propertyType": propertyType.value, // land | house | apartment
        "ownerName": controllerOwnerName.text.trim(),
        "ownerPhoneNumber": controllerOwnerPhoneNumber.text.trim(),
        "ownerCitizenId": controllerIdCard.text.trim(),
        "legalAreaSqm": controllerLegalAreaSqm.text.trim(),
        "status": "pending", // mặc định pending
        "actualAreaSqm": controllerActualAreaSqm.text.trim(),
        "frontageMeters": controllerFrontageMeters.text.trim(),
        "widthMeters": controllerWidthMeters.text.trim(),
        "numberOfFloors": controllerNumberOfFloors.text.trim(),
        "listingPriceVndSell":
            int.tryParse(controllerListingPriceVndSell.text.trim()) ?? 0,
        "listingPriceVndRent": 0, // chưa nhập thì để 0
        "commissionRatePercent":
            int.tryParse(controllerCommissionRatePercent.text.trim()) ?? 0,
        "commissionAmountVnd":
            int.tryParse(controllerCommissionAmountVnd.text.trim()) ?? 0,
        "provinceCode": provinceCode.value,
        "districtCode": districtCode.value,
        "wardCode": wardCode.value,
        "fullAddress": controllerFullAddress.text.trim(),
        "description": controllerDescription.text.trim(),
        "imageUrls": [],
        "tags": tags,
        "latitude": mapLatLng.value?.latitude,
        "longitude": mapLatLng.value?.longitude,
        "streetName": controllerStreetName.text.trim(),
        "legalStatus": "has_certificate", // default
        "landCertificate": {
          "code": controllerLandCertificateCode.text.trim(),
          "imageUrls": [],
        },
        "numberOfRooms": controllerNumberOfRooms.text.trim(),
        "numberOfBathrooms": controllerNumberOfBathrooms.text.trim(),
        "numberOfBalconies": controllerNumberOfBalconies.text.trim(),
      };

      final response = await apiMethod.post("listings", body: body);

      if (response.containsKey("error")) {
        LoadingNotifier.showTopMessage("${response['error']}", false);
        return;
      }

      LoadingNotifier.showTopMessage("Đăng tin thành công", true);
      Get.back(result: true);
    } catch (e) {
      LoadingNotifier.showTopMessage("Có lỗi xảy ra: $e", false);
    }
  }
}
