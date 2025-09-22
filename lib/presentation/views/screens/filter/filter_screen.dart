import 'package:app_real_estate/presentation/widgets/CriteriaSelection.dart';
import 'package:app_real_estate/presentation/widgets/LabeledDropdown.dart';
import 'package:app_real_estate/presentation/widgets/LabeledTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'filter_controller.dart';

class FilterScreen extends GetView<FilterController> {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                header(),
                Expanded(child: body()),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: buttonFilter(),
                ),
              ],
            ),
          ),
          Obx(() {
            if (controller.isLoading.value) {
              return Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(child: CircularProgressIndicator()),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: EdgeInsets.only(left: 12, bottom: 12, top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Bộ lọc tìm kiếm",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          InkWell(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.only(
                left: 12,
                bottom: 12,
                top: 12,
                right: 12,
              ),
              child: Icon(Icons.close, size: 16.w, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Obx(
              () => Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        controller.isSelectSell.value = true;
                      },
                      child: listingType(
                        isSelect: controller.isSelectSell.value,
                        title: "Tìm mua",
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        controller.isSelectSell.value = false;
                      },
                      child: listingType(
                        isSelect: !controller.isSelectSell.value,
                        title: "Tìm Thuê",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12.h),
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
                    color: Colors.red,
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
                                value: e.code, // <-- dùng code làm value
                                child: Text(e.fullName),
                              ),
                            )
                            .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        final selected = controller.provinces.firstWhere(
                          (p) => p.code == val,
                        );
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
                                child: Text(d.fullName), // hiển thị tên
                              ),
                            )
                            .toList(),
                    onChanged: (val) {
                      final selected = controller.districts.firstWhere(
                        (p) => p.code == val,
                      );
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
                            : controller.wardCode.value, // sẽ là code của ward
                    items:
                        controller.wards
                            .map(
                              (w) => DropdownMenuItem<String>(
                                value: w.code, // lưu code
                                child: Text(w.fullName), // hiển thị tên
                              ),
                            )
                            .toList(),
                    onChanged: (val) {
                      final selected = controller.wards.firstWhere(
                        (w) => w.code == val,
                      );
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
                CriteriaSelection(
                  label: "Tiêu chí",
                  options: controller.criteriaOptions,
                  selectedOptions: controller.selectedCriteria,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 12.h),

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tìm kiếm mở rộng",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Diện tích thực tế :",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Diện tích
                    Row(
                      children: [
                        Expanded(
                          child: LabeledTextField(
                            label: "Từ",
                            keyboardType: TextInputType.number,
                            suffixText: "m²",
                            controller: controller.minActualAreaSqm,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: LabeledTextField(
                            label: "Đến",
                            keyboardType: TextInputType.number,
                            suffixText: "m²",
                            controller: controller.maxActualAreaSqm,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    // Số tầng & Mặt tiền
                    Text(
                      "Số tầng :",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: LabeledTextField(
                            label: "Từ",
                            keyboardType: TextInputType.number,
                            suffixText: "tầng",
                            controller:
                                controller
                                    .minNumberOfFloors, // hoặc đổi tên cho rõ ràng
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: LabeledTextField(
                            label: "Đến",
                            suffixText: "tầng",
                            keyboardType: TextInputType.number,
                            controller: controller.maxNumberOfFloors,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Mặt tiền :",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: LabeledTextField(
                            label: "Từ",
                            keyboardType: TextInputType.number,
                            controller:
                                controller
                                    .minFrontageMeters, // hoặc đổi tên cho rõ ràng
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: LabeledTextField(
                            label: "Đến",
                            suffixText: "m",
                            keyboardType: TextInputType.number,
                            controller: controller.maxFrontageMeters,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 8.h),
        ],
      ),
    );
  }

  Widget listingType({required bool isSelect, required String title}) {
    return Container(
      decoration: BoxDecoration(
        color: isSelect ? Colors.redAccent : Colors.white,
        border: Border.all(color: isSelect ? Colors.redAccent : Colors.grey),
      ),
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
            color: isSelect ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget squareForm({
    required TextEditingController minController,
    required TextEditingController maxController,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Từ:",
          style: TextStyle(
            fontSize: 14.sp,
            color: Color(0xFF374151),
            fontWeight: FontWeight.normal,
          ),
        ),
        Expanded(
          child: TextField(
            controller: minController,
            decoration: InputDecoration(
              hintText: "",
              hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14.sp),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
            ),
            style: TextStyle(fontSize: 14.sp, color: Colors.black),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          "Đến:",
          style: TextStyle(
            fontSize: 14.sp,
            color: Color(0xFF374151),
            fontWeight: FontWeight.normal,
          ),
        ),
        Expanded(
          child: TextField(
            controller: maxController,
            decoration: InputDecoration(
              hintText: "",
              hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14.sp),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
            ),
            style: TextStyle(fontSize: 14.sp, color: Colors.black),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
        ),
      ],
    );
  }

  Widget buttonFilter() {
    return Container(
      width: Get.width,
      padding: EdgeInsets.only(top: 8.h),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: _buttonCustom(
              text: "Đặt lại",
              onTap: () {
                controller.resetFilter();
              },
            ),
          ),
          SizedBox(width: 12.w),
          Flexible(
            flex: 2,
            child: _buttonCustom(
              text: "Xem kết quả",
              bgColor: Colors.redAccent,
              textColor: Colors.white,
              borderSideColor: Colors.redAccent,
              onTap: () {
                controller.fetchListings();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonCustom({
    Color? bgColor,
    String text = "",
    Color? textColor,
    Color? borderSideColor,
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
          color: bgColor ?? Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: borderSideColor ?? Colors.grey),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: textColor ?? Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
