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
