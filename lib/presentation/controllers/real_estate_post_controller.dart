import 'dart:async';

import 'package:app_real_estate/core/utils/api/api_method.dart';
import 'package:app_real_estate/core/utils/notifier.dart';
import 'package:app_real_estate/data/models/UserModel.dart';
import 'package:app_real_estate/data/models/district.dart';
import 'package:app_real_estate/data/models/ward.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class RealEstatePostController extends GetxController {
  var title = ''.obs;
  var description = ''.obs;
  var propertyType = 'Đất nền'.obs;
  var selectedCriteria = <String>[].obs;
  var ownerName = ''.obs;
  var ownerPhone = ''.obs;
  var idCard = ''.obs;

  var legalArea = ''.obs;
  var actualArea = ''.obs;
  var frontage = ''.obs;
  var depth = ''.obs;

  var floors = ''.obs;
  var rooms = ''.obs;
  var bathrooms = ''.obs;
  var balconies = ''.obs;
  var selectedProvince = ''.obs;
  var selectedDistrict = ''.obs;
  var selectedWard = ''.obs;
  var streetName = ''.obs;
  var fullAddress = ''.obs;
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
  List<String> criteriaOptions = [
    'Triệu đô',
    'Lãi vốn (Rẻ)',
    'Hẻm ô tô',
    'Chính chủ',
    'Thang máy',
    'Để ở',
    'Để kinh doanh',
    'Dòng tiền ổn định',
    'Chủ cần bán gấp',
  ];

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
    selectedProvince.value = id;
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
    selectedDistrict.value = id;
    final dataFromServer = await apiMethod.get(
      "provinces/${selectedProvince.value}/districts/$id/wards",
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
}
