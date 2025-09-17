import 'dart:io';

import 'package:app_real_estate/presentation/widgets/CriteriaSelection.dart';
import 'package:app_real_estate/presentation/widgets/LabeledDropdown.dart';
import 'package:app_real_estate/presentation/widgets/LabeledMultilineTextField.dart';
import 'package:app_real_estate/presentation/widgets/LabeledTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/utils/constants/color_constants.dart';
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
      body: NotificationListener<ScrollNotification>(
        onNotification: (_) => false,
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
                        onChanged: (val) => controller.title.value = val,
                      ),
                      SizedBox(height: 16),
                      LabeledMultilineTextField(
                        label: "Mô tả",
                        hintText: "Nhập mô tả chi tiết...",
                        minLines: 4,
                        maxLines: 6,
                        helperText: "Tối thiểu 30 ký tự, tối đa 3000 ký tự",
                        onChanged: (val) => controller.description.value = val,
                      ),
                      SizedBox(height: 16),
                      Obx(
                        () => LabeledDropdown<String>(
                          label: "Loại bất động sản",
                          isRequired: true,
                          hintText: "Chọn loại bất động sản",
                          value:
                              controller.propertyType.value.isEmpty
                                  ? null
                                  : controller.propertyType.value,
                          items:
                              controller.propertyTypes
                                  .map(
                                    (type) => DropdownMenuItem<String>(
                                      value: type,
                                      child: Text(type),
                                    ),
                                  )
                                  .toList(),
                          onChanged:
                              (val) =>
                                  controller.propertyType.value = val ?? '',
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
                        onChanged: (val) => controller.ownerName.value = val,
                      ),
                      SizedBox(height: 16),
                      LabeledTextField(
                        label: "Số điện thoại chủ sở hữu",
                        hintText: "Số điện thoại",
                        isRequired: true,
                        onChanged: (val) => controller.ownerPhone.value = val,
                      ),
                      SizedBox(height: 16),
                      LabeledTextField(
                        label: "CCCD chủ sở hữu",
                        hintText: "Số điện thoại",
                        isRequired: true,
                        onChanged: (val) => controller.idCard.value = val,
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
                              onChanged:
                                  (val) => controller.legalArea.value = val,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: LabeledTextField(
                              label: "Diện tích thực tế",
                              isRequired: true,
                              keyboardType: TextInputType.number,
                              suffixText: "m²",
                              onChanged:
                                  (val) => controller.actualArea.value = val,
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
                              keyboardType: TextInputType.number,
                              onChanged:
                                  (val) => controller.frontage.value = val,
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
                              onChanged: (val) => controller.depth.value = val,
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
                              onChanged: (val) => controller.floors.value = val,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: LabeledTextField(
                              label: "Số phòng",
                              hintText: "",
                              suffixText: "phòng",
                              keyboardType: TextInputType.number,
                              onChanged: (val) => controller.rooms.value = val,
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
                              onChanged:
                                  (val) => controller.bathrooms.value = val,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: LabeledTextField(
                              label: "Số phòng ban công",
                              hintText: "",
                              suffixText: "bc",
                              keyboardType: TextInputType.number,
                              onChanged:
                                  (val) => controller.balconies.value = val,
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
                        label: "Giá chào",
                        hintText: "",
                        isRequired: true,
                        suffixText: "VND",
                        keyboardType: TextInputType.number,
                        onChanged: (val) => controller.depth.value = val,
                      ),
                      SizedBox(height: 16.h),
                      LabeledTextField(
                        label: "Phần trăm hoa hồng",
                        hintText: "",
                        isRequired: true,
                        suffixText: "%",
                        keyboardType: TextInputType.number,
                        onChanged: (val) => controller.depth.value = val,
                      ),
                      SizedBox(height: 16.h),
                      LabeledTextField(
                        label: "Số tiền hoa hồng",
                        hintText: "",
                        isRequired: true,
                        suffixText: "VND",
                        keyboardType: TextInputType.number,
                        onChanged: (val) => controller.depth.value = val,
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
                              controller.selectedProvince.value.isEmpty
                                  ? null
                                  : controller.selectedProvince.value,
                          items:
                              ['Thành phố Hà Nội', 'Thành phố Hồ Chí Minh']
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                          onChanged:
                              (val) =>
                                  controller.selectedProvince.value = val ?? '',
                        ),
                      ),
                      SizedBox(height: 12),
                      LabeledDropdown<String>(
                        label: "Quận/Huyện",
                        isRequired: true,
                        hintText: "Chọn quận/huyện",
                        value:
                            controller.selectedDistrict.value.isEmpty
                                ? null
                                : controller.selectedDistrict.value,
                        items:
                            ['Quận 1', 'Quận 3', 'Bình Thạnh']
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                        onChanged:
                            (val) =>
                                controller.selectedDistrict.value = val ?? '',
                      ),

                      SizedBox(height: 12),

                      LabeledDropdown<String>(
                        label: "Phường/Xã",
                        isRequired: true,
                        hintText: "Chọn phường/xã",
                        value:
                            controller.selectedWard.value.isEmpty
                                ? null
                                : controller.selectedWard.value,
                        items:
                            ['Phường 1', 'Phường 5', 'Phường 7']
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                        onChanged:
                            (val) => controller.selectedWard.value = val ?? '',
                      ),
                      SizedBox(height: 12),
                      LabeledTextField(
                        label: "Tên đường",
                        hintText: "Nhập tên đường",
                        isRequired: true,
                        onChanged: (val) => controller.streetName.value = val,
                      ),
                      SizedBox(height: 12),
                      LabeledTextField(
                        label: "Địa chỉ chi tiết",
                        hintText: "Số nhà, đường, phường/xã",
                        isRequired: true,
                        onChanged: (val) => controller.streetName.value = val,
                      ),
                      SizedBox(height: 12),
                      _buildGoogleMapSection(),
                      SizedBox(height: 12),
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
                      LabeledTextField(
                        label: "Số serial sổ",
                        hintText: "Mã số giấy tờ pháp lý",
                        isRequired: true,
                        onChanged: (val) => controller.streetName.value = val,
                      ),
                      SizedBox(height: 16),
                      _buildLabel('Hình ảnh giấy tờ pháp lý'),
                      _buildSelectImageLegal(context),
                    ],
                  ),
                ),

                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ButtonPrimary(
                      content: "Lưu nháp",
                      color: Colors.white,
                      boxBorder: Border.all(width: 1, color: Colors.grey),
                    ),
                    SizedBox(width: 12),
                    ButtonPrimary(
                      content: "Xác nhận",
                      color: ColorConstant.primaryColor,
                      horizontalPadding: 16,
                      verticalPadding: 12,
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
              ],
            ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        _buildLabel('Vị trí trên bản đồ'),
        const SizedBox(height: 8),
        Container(
          height: 250,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Listener(
            onPointerDown: (_) => controller.isMapInteracting.value = true,
            onPointerUp: (_) => controller.isMapInteracting.value = false,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target:
                    controller.mapLatLng.value ?? LatLng(10.762622, 106.660172),
                zoom: 16,
              ),
              onTap: (LatLng pos) {
                controller.mapLatLng.value = pos;
              },
              markers:
                  controller.mapLatLng.value == null
                      ? {}
                      : {
                        Marker(
                          markerId: MarkerId('selected'),
                          position: controller.mapLatLng.value!,
                        ),
                      },
              zoomControlsEnabled: true,
              compassEnabled: true,
              myLocationEnabled: true,
              mapToolbarEnabled: true,
              scrollGesturesEnabled: true,
              tiltGesturesEnabled: true,
              rotateGesturesEnabled: true,
            ),
          ),
        ),
      ],
    );
  }
}
