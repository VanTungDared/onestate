import 'dart:io';

import 'package:app_real_estate/core/utils/constants/convert_app.dart';
import 'package:app_real_estate/core/utils/notifier.dart';
import 'package:app_real_estate/data/models/option.dart';
import 'package:app_real_estate/presentation/widgets/ButtonPrimary%20copy.dart';
import 'package:app_real_estate/presentation/widgets/CriteriaSelection.dart';
import 'package:app_real_estate/presentation/widgets/LabeledDropdown.dart';
import 'package:app_real_estate/presentation/widgets/LabeledMultilineTextField.dart';
import 'package:app_real_estate/presentation/widgets/LabeledTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/utils/image_utils.dart';
import '../../controllers/real_estate_post_controller.dart';
import '../../widgets/ButtonPrimary.dart';

class RealEstateFormScreen extends StatelessWidget {
  final controller = Get.put(RealEstatePostController());

  RealEstateFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text(
          'Đăng Tin Mới',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: NotificationListener<ScrollNotification>(
          onNotification: (_) => false,
          child: Column(
            children: [
              Expanded(
                child: Obx(
                  () => SingleChildScrollView(
                    physics:
                        controller.isMapInteracting.value
                            ? const NeverScrollableScrollPhysics()
                            : const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.all(12),
                          margin: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Thông tin chính",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              LabeledTextField(
                                label: "Tiêu đề",
                                hintText: "Tiêu đề bài viết",
                                isRequired: true,
                                controller: controller.controllerTitle,
                              ),
                              SizedBox(height: 16),
                              Obx(
                                () => LabeledMultilineTextField(
                                  label: "Mô tả",
                                  hintText: "Nhập mô tả chi tiết...",
                                  minLines: 4,
                                  isRequired: true,
                                  maxLines: 6,
                                  helperText:
                                      "Tối thiểu 30 ký tự, tối đa 3000 ký tự (${controller.countDescription.value} ký tự)",
                                  controller: controller.controllerDescription,
                                  onChanged:
                                      (val) =>
                                          controller.countDescription.value =
                                              val.length,
                                ),
                              ),
                              SizedBox(height: 16),
                              Obx(
                                () => LabeledDropdown<OptionModel>(
                                  label: "Loại bài viết",
                                  isRequired: true,
                                  hintText: "Chọn loại bài viết",
                                  value: controller.listingType.value,
                                  items:
                                      controller.listingTypes
                                          .map(
                                            (type) =>
                                                DropdownMenuItem<OptionModel>(
                                                  value: type,
                                                  child: Text(type.label),
                                                ),
                                          )
                                          .toList(),
                                  onChanged: (val) {
                                    controller.listingType.value = val;
                                  },
                                ),
                              ),

                              SizedBox(height: 16),
                              Obx(
                                () => LabeledDropdown<OptionModel>(
                                  label: "Loại bất động sản",
                                  isRequired: true,
                                  hintText: "Chọn loại bất động sản",
                                  value: controller.propertyType.value,
                                  items:
                                      controller.propertyTypes
                                          .map(
                                            (type) =>
                                                DropdownMenuItem<OptionModel>(
                                                  value: type,
                                                  child: Text(type.label),
                                                ),
                                          )
                                          .toList(),
                                  onChanged: (val) {
                                    controller.propertyType.value = val;
                                  },
                                ),
                              ),

                              SizedBox(height: 16),
                              CriteriaSelection(
                                label: "Tiêu chí",
                                options: controller.criteriaOptions,
                                selectedOptions: controller.selectedCriteria,
                              ),
                              SizedBox(height: 16),
                              LabeledTextField(
                                label: "Chủ sở hữu",
                                hintText: "Họ và Tên",
                                isRequired: true,
                                controller: controller.controllerOwnerName,
                              ),
                              SizedBox(height: 16),
                              LabeledTextField(
                                keyboardType: TextInputType.phone,
                                label: "Số điện thoại chủ sở hữu",
                                hintText: "Số điện thoại",
                                isRequired: true,
                                controller:
                                    controller.controllerOwnerPhoneNumber,
                              ),
                              SizedBox(height: 16),
                              LabeledTextField(
                                label: "CCCD chủ sở hữu",
                                hintText: "Số điện thoại",
                                isRequired: true,
                                controller: controller.controllerIdCard,
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: LabeledTextField(
                                      label: "Diện tích pháp lý",
                                      isRequired: true,
                                      keyboardType: TextInputType.number,
                                      suffixText: "m²",
                                      controller:
                                          controller.controllerLegalAreaSqm,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: LabeledTextField(
                                      label: "Diện tích thực tế",
                                      isRequired: true,
                                      keyboardType: TextInputType.number,
                                      suffixText: "m²",
                                      controller:
                                          controller.controllerActualAreaSqm,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: LabeledTextField(
                                      label: "Mặt tiền",
                                      hintText: "",
                                      suffixText: "m",
                                      isRequired: true,
                                      keyboardType: TextInputType.number,
                                      controller:
                                          controller.controllerFrontageMeters,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: LabeledTextField(
                                      label: "Chiều sâu",
                                      hintText: "",
                                      isRequired: true,
                                      suffixText: "m",
                                      keyboardType: TextInputType.number,
                                      controller:
                                          controller.controllerWidthMeters,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: LabeledTextField(
                                      label: "Số tầng",
                                      hintText: "",
                                      suffixText: "tầng",
                                      keyboardType: TextInputType.number,
                                      controller:
                                          controller.controllerNumberOfFloors,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: LabeledTextField(
                                      label: "Số phòng",
                                      hintText: "",
                                      suffixText: "phòng",
                                      keyboardType: TextInputType.number,
                                      controller:
                                          controller.controllerNumberOfRooms,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: LabeledTextField(
                                      label: "Số phòng tắm/WC",
                                      hintText: "",
                                      suffixText: "phòng",
                                      keyboardType: TextInputType.number,
                                      controller:
                                          controller
                                              .controllerNumberOfBathrooms,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: LabeledTextField(
                                      label: "Số phòng ban công",
                                      hintText: "",
                                      suffixText: "bc",
                                      keyboardType: TextInputType.number,
                                      controller:
                                          controller
                                              .controllerNumberOfBalconies,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.all(12),
                          margin: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tài chính",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              LabeledTextField(
                                label: "Giá chào (VND)",
                                hintText: "",
                                isRequired: true,
                                suffixText: "VND",
                                keyboardType: TextInputType.number,
                                controller:
                                    controller.controllerListingPriceVndSell,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  VNDTextInputFormatter(),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              LabeledTextField(
                                label: "Phần trăm hoa hồng (%)",
                                hintText: "",
                                suffixText: "%",
                                keyboardType: TextInputType.number,
                                controller:
                                    controller.controllerCommissionRatePercent,
                              ),
                              SizedBox(height: 16.h),
                              LabeledTextField(
                                label: "Số tiền hoa hồng (VND)",
                                hintText: "",
                                suffixText: "VND",
                                keyboardType: TextInputType.number,
                                controller:
                                    controller.controllerCommissionAmountVnd,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  VNDTextInputFormatter(),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.all(12),
                          margin: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Địa chỉ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Obx(
                                () => LabeledDropdown<String>(
                                  label: "Tỉnh/Thành phố",
                                  isRequired: true,
                                  hintText: "Chọn tỉnh/thành phố",
                                  value:
                                      controller.provinceCode.value.isEmpty
                                          ? null
                                          : controller
                                              .provinceCode
                                              .value, // code: "01" hoặc "79"
                                  items:
                                      controller.provinces
                                          .map(
                                            (e) => DropdownMenuItem<String>(
                                              value:
                                                  e.code, // <-- dùng code làm value
                                              child: Text(e.fullName),
                                            ),
                                          )
                                          .toList(),
                                  onChanged: (val) {
                                    if (val != null) {
                                      final selected = controller.provinces
                                          .firstWhere((p) => p.code == val);
                                      controller.handleSelectProvince(
                                        selected.fullName,
                                        selected.code,
                                      );
                                    }
                                  },
                                ),
                              ),

                              SizedBox(height: 12),
                              Obx(
                                () => LabeledDropdown<String>(
                                  label: "Quận/Huyện",
                                  isRequired: true,
                                  hintText: "Chọn quận/huyện",
                                  value:
                                      controller.districtCode.value.isEmpty
                                          ? null
                                          : controller
                                              .districtCode
                                              .value, // sẽ là code của district
                                  items:
                                      controller.districts
                                          .map(
                                            (d) => DropdownMenuItem<String>(
                                              value: d.code, // lưu code
                                              child: Text(
                                                d.fullName,
                                              ), // hiển thị tên
                                            ),
                                          )
                                          .toList(),
                                  onChanged: (val) {
                                    final selected = controller.districts
                                        .firstWhere((p) => p.code == val);
                                    controller.handleSelectDistrict(
                                      selected.fullName,
                                      selected.code,
                                    );
                                  },
                                ),
                              ),

                              SizedBox(height: 12),

                              Obx(
                                () => LabeledDropdown<String>(
                                  label: "Phường/Xã",
                                  isRequired: true,
                                  hintText: "Chọn phường/xã",
                                  value:
                                      controller.wardCode.value.isEmpty
                                          ? null
                                          : controller
                                              .wardCode
                                              .value, // sẽ là code của ward
                                  items:
                                      controller.wards
                                          .map(
                                            (w) => DropdownMenuItem<String>(
                                              value: w.code, // lưu code
                                              child: Text(
                                                w.fullName,
                                              ), // hiển thị tên
                                            ),
                                          )
                                          .toList(),
                                  onChanged: (val) {
                                    final selected = controller.wards
                                        .firstWhere((w) => w.code == val);
                                    controller.handleSelectWard(
                                      selected.fullName,
                                      selected.code,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 12),
                              LabeledTextField(
                                label: "Tên đường",
                                hintText: "Nhập tên đường",
                                isRequired: true,
                                controller: controller.controllerStreetName,
                              ),
                              SizedBox(height: 12),
                              LabeledTextField(
                                label: "Địa chỉ chi tiết",
                                hintText: "Số nhà, đường, phường/xã",
                                isRequired: true,
                                controller: controller.controllerFullAddress,
                              ),
                              SizedBox(height: 12),
                              _buildGoogleMapSection(),
                            ],
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.all(12),
                          margin: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hình ảnh",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              _buildSelectImage(context),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.all(12),
                          margin: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pháp lý",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Obx(
                                () => LabeledDropdown<OptionModel>(
                                  label: "Tình trạng pháp lý",
                                  isRequired: true,
                                  hintText: "Chọn tình trạng pháp lý",
                                  value: controller.legalStatus.value,
                                  items:
                                      controller.legalStatusOptions
                                          .map(
                                            (status) =>
                                                DropdownMenuItem<OptionModel>(
                                                  value: status,
                                                  child: Text(status.label),
                                                ),
                                          )
                                          .toList(),
                                  onChanged: (val) {
                                    controller.legalStatus.value = val;
                                  },
                                ),
                              ),

                              SizedBox(height: 12),
                              LabeledTextField(
                                label: "Số sổ đỏ",
                                hintText: "Nhập số sổ",
                                isRequired: true,
                                controller:
                                    controller.controllerLandCertificateCode,
                              ),
                              SizedBox(height: 16),
                              _buildLabel('Hình ảnh giấy tờ pháp lý'),
                              _buildSelectImageLegal(context),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey, width: 0.2),
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        text: "Lưu nháp",
                        isOutlined: true, // viền cam, nền trắng
                        onPressed: () => {},
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: PrimaryButton(
                        text: "Xác nhận",
                        onPressed: () => controller.handleConfirm(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectImage(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ButtonPrimary(
        content: "Chọn ảnh tải lên",
        icon: const Icon(Icons.add),
        callBack: () => controller.pickMultipleImages(),
      ),
      const SizedBox(height: 12),
      Obx(() {
        if (controller.renderImage.value == 0) return const SizedBox();

        // Kích thước mỗi ảnh = 1/3 chiều rộng màn hình (trừ padding)
        final double itemSize =
            (MediaQuery.of(context).size.width - (48 + 12.w + 12.w)) / 3;

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children:
              controller.images.map((image) {
                return Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder:
                              (_) => Dialog(
                                backgroundColor: Colors.black,
                                insetPadding: EdgeInsets.zero,
                                child: Stack(
                                  children: [
                                    InteractiveViewer(
                                      child: Center(
                                        child: ImageUtils.loadFormFile(
                                          File(image.path),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 16,
                                      right: 16,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.close,
                                          color: Colors.black,
                                          size: 28,
                                        ),
                                        onPressed:
                                            () => Navigator.of(context).pop(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        );
                      },
                      child: Container(
                        width: itemSize,
                        height: itemSize,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: ImageUtils.loadFormFile(
                            File(image.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: InkWell(
                        onTap: () => controller.removeImage(image),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(4),
                          child: const Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
        );
      }),
    ],
  );

  Widget _buildSelectImageLegal(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ButtonPrimary(
        content: "Chọn ảnh tải lên",
        icon: const Icon(Icons.add),
        callBack: () => controller.pickMultipleImagesLegal(),
      ),
      const SizedBox(height: 12),
      Obx(() {
        if (controller.renderImageLegal.value == 0) return const SizedBox();

        // Kích thước mỗi ảnh = 1/3 chiều rộng màn hình (trừ padding)
        final double itemSize =
            (MediaQuery.of(context).size.width - (48 + 12.w + 12.w)) / 3;

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children:
              controller.imagesLegal.map((image) {
                return Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder:
                              (_) => Dialog(
                                backgroundColor: Colors.black,
                                insetPadding: EdgeInsets.zero,
                                child: Stack(
                                  children: [
                                    InteractiveViewer(
                                      child: Center(
                                        child: ImageUtils.loadFormFile(
                                          File(image.path),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 16,
                                      right: 16,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                        onPressed:
                                            () => Navigator.of(context).pop(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        );
                      },
                      child: Container(
                        width: itemSize,
                        height: itemSize,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: ImageUtils.loadFormFile(
                            File(image.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: InkWell(
                        onTap: () => controller.removeImageLegal(image),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(4),
                          child: const Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
        );
      }),
    ],
  );

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
    ),
  );

  Widget _buildGoogleMapSection() {
    final urlController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        _buildLabel('Vị trí trên bản đồ'),
        const SizedBox(height: 8),
        // Ô nhập URL Google Maps
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextField(
                controller: urlController,
                decoration: InputDecoration(
                  hintText: "Dán URL Google Maps",
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 12,
                  ),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 1.2,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: PrimaryButton(
                text: "Chọn",
                onPressed: () async {
                  final result = ConvertApp.extractLatLngFromGoogleMapsUrl(
                    urlController.text.trim(),
                  );
                  if (result != null && result["lat"] != null) {
                    controller.lat.value = result["lat"] ?? 0.0;
                    controller.lng.value = result["lng"] ?? 0.0;
                  } else {
                    LoadingNotifier.showTopMessage(
                      "Lấy vị trí không thành công",
                      true,
                    );
                  }
                },
                height: 32.h,
                borderRadius: 8,
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        // Bản đồ
        // Container(
        //   height: 250,
        //   decoration: BoxDecoration(
        //     border: Border.all(color: Colors.grey.shade300),
        //   ),
        //   child: Listener(
        //     onPointerDown: (_) => controller.isMapInteracting.value = true,
        //     onPointerUp: (_) => controller.isMapInteracting.value = false,
        //     child: GoogleMap(
        //       onMapCreated: (GoogleMapController controllerGoogle) {
        //         controller.mapController.complete(controllerGoogle);
        //       },
        //       initialCameraPosition: CameraPosition(
        //         target:
        //             controller.mapLatLng.value ?? LatLng(10.762622, 106.660172),
        //         zoom: 16,
        //       ),
        //       onTap: (LatLng pos) {
        //         controller.mapLatLng.value = pos;
        //       },
        //       markers:
        //           controller.mapLatLng.value == null
        //               ? {}
        //               : {
        //                 Marker(
        //                   markerId: MarkerId('selected'),
        //                   position: controller.mapLatLng.value!,
        //                 ),
        //               },
        //       zoomControlsEnabled: true,
        //       compassEnabled: true,
        //       myLocationEnabled: true,
        //       mapToolbarEnabled: true,
        //       scrollGesturesEnabled: true,
        //       tiltGesturesEnabled: true,
        //       rotateGesturesEnabled: true,
        //     ),
        //   ),
        // ),
        const SizedBox(height: 8),

        // Hiển thị tọa độ
        Obx(() {
          if (controller.lat.value == 0.0 || controller.lng.value == 0.0) {
            return Text("Chưa chọn vị trí");
          } else {
            final lat = controller.lat.value.toStringAsFixed(6);
            final lng = controller.lng.value.toStringAsFixed(6);
            return Text("Tọa độ đã chọn: $lat, $lng");
          }
        }),
      ],
    );
  }

  // LatLng? _extractLatLngFromUrl(String url) {
  //   if (url.trim().isEmpty) return null;
  //   final decoded = Uri.decodeFull(url);

  //   // 1) !3d{lat}!4d{lng} (thường là toạ độ chính xác của marker)
  //   final reg34 = RegExp(r'!3d(-?\d+(?:\.\d+)?)!4d(-?\d+(?:\.\d+)?)');
  //   final m34 = reg34.firstMatch(decoded);
  //   if (m34 != null) {
  //     final lat = double.tryParse(m34.group(1)!);
  //     final lng = double.tryParse(m34.group(2)!);
  //     if (lat != null && lng != null) return LatLng(lat, lng);
  //   }

  //   // 2) @lat,lng,...
  //   final regAt = RegExp(r'@(-?\d+(?:\.\d+)?),(-?\d+(?:\.\d+)?)(?:,|$)');
  //   final mAt = regAt.firstMatch(decoded);
  //   if (mAt != null) {
  //     final lat = double.tryParse(mAt.group(1)!);
  //     final lng = double.tryParse(mAt.group(2)!);
  //     if (lat != null && lng != null) return LatLng(lat, lng);
  //   }

  //   // 3) ?q=lat,lng or &q=lat,lng
  //   final regQ = RegExp(r'[?&]q=(-?\d+(?:\.\d+)?),(-?\d+(?:\.\d+)?)');
  //   final mQ = regQ.firstMatch(decoded);
  //   if (mQ != null) {
  //     final lat = double.tryParse(mQ.group(1)!);
  //     final lng = double.tryParse(mQ.group(2)!);
  //     if (lat != null && lng != null) return LatLng(lat, lng);
  //   }

  //   // 4) DMS pattern: ví dụ 21°04'04.5"N 105°46'26.5"E  (hỗ trợ dấu Unicode và phân cách +, space, comma)
  //   final regDMS = RegExp(
  //     r'''([+-]?\d{1,3})[°\s]+(\d{1,2})['’\s]+(\d{1,2}(?:\.\d+)?)(?:["”])?\s*([NSns])[\s\+,]+([+-]?\d{1,3})[°\s]+(\d{1,2})['’\s]+(\d{1,2}(?:\.\d+)?)(?:["”])?\s*([EWew])''',
  //   );
  //   final mDMS = regDMS.firstMatch(decoded);
  //   if (mDMS != null) {
  //     double dmsToDec(String deg, String min, String sec, String hemi) {
  //       final dd = double.parse(deg);
  //       final mm = double.parse(min);
  //       final ss = double.parse(sec);
  //       var val = dd + mm / 60 + ss / 3600;
  //       final h = hemi.toUpperCase();
  //       if (h == 'S' || h == 'W') val = -val;
  //       return val;
  //     }

  //     final lat = dmsToDec(
  //       mDMS.group(1)!,
  //       mDMS.group(2)!,
  //       mDMS.group(3)!,
  //       mDMS.group(4)!,
  //     );
  //     final lng = dmsToDec(
  //       mDMS.group(5)!,
  //       mDMS.group(6)!,
  //       mDMS.group(7)!,
  //       mDMS.group(8)!,
  //     );
  //     return LatLng(lat, lng);
  //   }

  //   // 5) Fallback: bất kỳ cặp số thập phân "lat,lng"
  //   final regAny = RegExp(r'(-?\d{1,3}\.\d+),\s*(-?\d{1,3}\.\d+)');
  //   final mAny = regAny.firstMatch(decoded);
  //   if (mAny != null) {
  //     final lat = double.tryParse(mAny.group(1)!);
  //     final lng = double.tryParse(mAny.group(2)!);
  //     if (lat != null && lng != null) return LatLng(lat, lng);
  //   }

  //   return null;
  // }
}
