import 'dart:async';

import 'package:app_real_estate/core/utils/api/api_method.dart';
import 'package:app_real_estate/core/utils/notifier.dart';
import 'package:app_real_estate/data/models/UserModel.dart';
import 'package:app_real_estate/data/models/district.dart';
import 'package:app_real_estate/data/models/ward.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class RealEstatePostController extends GetxController {
  final controllerTitle = TextEditingController();
  final controllerDescription = TextEditingController();
  var propertyType = 'Đất nền'.obs;
  var listingType = 'Bán'.obs;
  var selectedCriteria = <Map<String, dynamic>>[].obs;
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

  List<String> propertyTypes = ['Đất nền', 'Nhà', 'Căn hộ'];
  List<String> listingTypes = ['Bán', 'Cho thuê'];
  final Map<String, String> criteriaOptions = {
    'Triệu đô': 'million_dollar',
    'Để ở': 'residential',
    'Lãi vốn (Rẻ)': 'investment',
    'Để kinh doanh': 'business',
    'Hẻm ô tô': 'car_access',
    'Đóng tiền ổn định': 'stable_cash_flow',
    'Chính chủ': 'owner_direct',
    'Chủ cần bán gấp': 'need_sell_fast',
  };

  final Rxn<UserModel> userModel = Rxn<UserModel>();

  final mapController = Completer<GoogleMapController>();

  @override
  void onInit() async {
    super.onInit();
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
}
