import 'dart:io';

import 'package:app_real_estate/constants/color_constants.dart';
import 'package:app_real_estate/controllers/real_estate_post_controller.dart';
import 'package:app_real_estate/utils/image_utils.dart';
import 'package:app_real_estate/views/widgets/ButtonPrimary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RealEstateFormScreen extends StatelessWidget {
  final controller = Get.put(RealEstatePostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Đăng tin mới')),
      body: NotificationListener<ScrollNotification>(
        onNotification: (_) => false,

        child: Obx(
          () => SingleChildScrollView(
            physics:
                controller.isMapInteracting.value
                    ? const NeverScrollableScrollPhysics()
                    : const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel('Tiêu đề *'),
                TextField(
                  decoration: InputDecoration(hintText: 'Tiêu đề bài viết'),
                  onChanged: (val) => controller.title.value = val,
                ),
                SizedBox(height: 16),
                _buildLabel('Mô tả'),
                TextField(
                  minLines: 4,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: '',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (val) => controller.description.value = val,
                ),
                SizedBox(height: 4),
                Text(
                  'Tối thiểu 30 ký tự, tối đa 3000 ký tự',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                SizedBox(height: 16),
                _buildLabel('Loại bất động sản *'),
                Obx(
                  () => DropdownButtonFormField<String>(
                    value: controller.propertyType.value,
                    items:
                        controller.propertyTypes
                            .map(
                              (type) => DropdownMenuItem<String>(
                                value: type,
                                child: Text(type),
                              ),
                            )
                            .toList(),
                    onChanged: (val) => controller.propertyType.value = val!,
                  ),
                ),
                SizedBox(height: 16),
                _buildLabel('Tiêu chí'),
                Obx(
                  () => Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children:
                        controller.criteriaOptions
                            .map(
                              (criteria) => Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                    value: controller.selectedCriteria.contains(
                                      criteria,
                                    ),
                                    onChanged: (val) {
                                      if (val!) {
                                        controller.selectedCriteria.add(
                                          criteria,
                                        );
                                      } else {
                                        controller.selectedCriteria.remove(
                                          criteria,
                                        );
                                      }
                                    },
                                  ),
                                  Text(criteria),
                                ],
                              ),
                            )
                            .toList(),
                  ),
                ),
                SizedBox(height: 16),
                _buildLabel('Chủ sở hữu *'),
                TextField(
                  decoration: InputDecoration(hintText: 'Tên chủ sở hữu'),
                  onChanged: (val) => controller.ownerName.value = val,
                ),
                SizedBox(height: 16),
                _buildLabel('Số điện thoại chủ sở hữu *'),
                TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Số điện thoại chủ sở hữu',
                  ),
                  onChanged: (val) => controller.ownerPhone.value = val,
                ),
                SizedBox(height: 24),
                SizedBox(height: 16),
                _buildLabel('CCCD/CMND chủ sở hữu'),
                TextField(
                  decoration: InputDecoration(hintText: 'CCCD/CMND chủ sở hữu'),
                  onChanged: (val) => controller.idCard.value = val,
                ),

                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('Diện tích pháp lý *'),
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(suffixText: 'm²'),
                            onChanged:
                                (val) => controller.legalArea.value = val,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('Diện tích thực tế *'),
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(suffixText: 'm²'),
                            onChanged:
                                (val) => controller.actualArea.value = val,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('Mặt tiền'),
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(suffixText: 'm'),
                            onChanged: (val) => controller.frontage.value = val,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('Chiều sâu *'),
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(suffixText: 'm'),
                            onChanged: (val) => controller.depth.value = val,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('Số tầng'),
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(suffixText: 'tầng'),
                            onChanged: (val) => controller.floors.value = val,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('Số phòng'),
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(suffixText: 'phòng'),
                            onChanged: (val) => controller.rooms.value = val,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('Số phòng tắm/WC'),
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(suffixText: 'phòng'),
                            onChanged:
                                (val) => controller.bathrooms.value = val,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('Số phòng ban công'),
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(suffixText: 'bc'),
                            onChanged:
                                (val) => controller.balconies.value = val,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 32),
                Text(
                  'Địa chỉ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 12),

                _buildLabel('Tỉnh/Thành phố *'),
                Obx(
                  () => DropdownButtonFormField<String>(
                    value:
                        controller.selectedProvince.value.isEmpty
                            ? null
                            : controller.selectedProvince.value,
                    hint: Text('Chọn tỉnh/thành'),
                    items:
                        ['TP.HCM', 'Hà Nội', 'Đà Nẵng']
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                    onChanged:
                        (val) => controller.selectedProvince.value = val!,
                  ),
                ),

                SizedBox(height: 12),
                _buildLabel('Quận/Huyện *'),
                Obx(
                  () => DropdownButtonFormField<String>(
                    value:
                        controller.selectedDistrict.value.isEmpty
                            ? null
                            : controller.selectedDistrict.value,
                    hint: Text('Chọn quận/huyện'),
                    items:
                        ['Quận 1', 'Quận 3', 'Bình Thạnh']
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                    onChanged:
                        (val) => controller.selectedDistrict.value = val!,
                  ),
                ),

                SizedBox(height: 12),
                _buildLabel('Phường/Xã *'),
                Obx(
                  () => DropdownButtonFormField<String>(
                    value:
                        controller.selectedWard.value.isEmpty
                            ? null
                            : controller.selectedWard.value,
                    hint: Text('Chọn phường/xã'),
                    items:
                        ['Phường 1', 'Phường 5', 'Phường 7']
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                    onChanged: (val) => controller.selectedWard.value = val!,
                  ),
                ),

                SizedBox(height: 12),
                _buildLabel('Tên đường *'),
                TextField(
                  decoration: InputDecoration(hintText: 'Tên đường'),
                  onChanged: (val) => controller.streetName.value = val,
                ),

                SizedBox(height: 12),
                _buildLabel('Địa chỉ chi tiết *'),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Số nhà, đường, phường/xã',
                  ),
                  onChanged: (val) => controller.fullAddress.value = val,
                ),

                SizedBox(height: 16),
                _buildGoogleMapSection(),
                SizedBox(height: 12),
                _buildLabel('Hình ảnh'),
                _buildSelectImage(),
                SizedBox(height: 12),
                _buildLabel('Pháp lý'),
                SizedBox(height: 12),
                _buildLabel('Số serial sổ *'),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Mã số giấy tờ pháp lý',
                  ),
                  onChanged: (val) => controller.legalDocumentsSeri.value = val,
                ),
                SizedBox(height: 12),
                _buildLabel('Hình ảnh giấy tờ pháp lý'),
                SizedBox(height: 12),
                _buildSelectImageLegal(),
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

  Widget _buildSelectImage() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      ButtonPrimary(
        content: "Chọn ảnh tải lên",
        icon: Icon(Icons.add),
        callBack: () => controller.pickMultipleImages(),
      ),
      Obx(() {
        if (controller.renderImage.value == 0) return SizedBox();

        return Column(
          children:
              controller.images.map((image) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      // Ảnh
                      Container(
                        width: 80,
                        height: 80,
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: ImageUtils.loadFormFile(
                          File(image.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Nút xoá
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => controller.removeImage(image),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
        );
      }),
    ],
  );

  Widget _buildSelectImageLegal() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      ButtonPrimary(
        content: "Chọn ảnh tải lên",
        icon: Icon(Icons.add),
        callBack: () => controller.pickMultipleImagesLegal(),
      ),
      Obx(() {
        if (controller.renderImageLegal.value == 0) return SizedBox();
        return Column(
          children:
              controller.imagesLegal.map((image) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      // Ảnh
                      Container(
                        width: 80,
                        height: 80,
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: ImageUtils.loadFormFile(
                          File(image.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Nút xoá
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => controller.removeImageLegal(image),
                          ),
                        ),
                      ),
                    ],
                  ),
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
