import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'filter_controller.dart';
import 'widget/group_checkbox.dart';

class FilterScreen extends GetView<FilterController> {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.w),
              child: Column(
                children: [
                  header(),
                  SizedBox(height: 12.h),
                  Expanded(child: body()),
                  buttonFilter(),
                ],
              ),
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
    return Row(
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
        IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.close, size: 16.w, color: Colors.grey),
        ),
      ],
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(child: listingType(isSelect: true, title: "Tìm mua")),
              Expanded(child: listingType(isSelect: false, title: "Tìm Thuê")),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            "Khu vực",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
              color: Colors.red,
            ),
          ),
          SizedBox(height: 8.h),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '* ',
                  style: TextStyle(color: Colors.red, fontSize: 14.sp),
                ),
                TextSpan(
                  text: 'Tỉnh/Thành phố',
                  style: TextStyle(
                    color: Color(0xFF374151),
                    fontWeight: FontWeight.normal,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Obx(
            () => Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: DropdownButton<String>(
                value:
                    controller.selectedCityId.value.isEmpty
                        ? null
                        : controller.selectedCityId.value,
                hint: const Text("Chọn thành phố"),
                isExpanded: true,
                items:
                    controller.listCity.entries.map((entry) {
                      return DropdownMenuItem<String>(
                        value: entry.key,
                        child: Text(entry.value),
                      );
                    }).toList(),
                onChanged: (String? newId) {
                  if (newId != null) {
                    controller.selectedCityId.value = newId;
                    controller.getDistricts();
                  }
                },
              ),
            ),
          ),
          SizedBox(height: 12.h),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '* ',
                  style: TextStyle(color: Colors.red, fontSize: 14.sp),
                ),
                TextSpan(
                  text: 'Quận/Huyện',
                  style: TextStyle(
                    color: Color(0xFF374151),
                    fontWeight: FontWeight.normal,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Obx(
            () => Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: DropdownButton<String>(
                value:
                    controller.selectedDistrictCode.value.isEmpty
                        ? null
                        : controller.selectedDistrictCode.value,
                hint: const Text("Quận, huyện"),
                isExpanded: true,
                items:
                    controller.districts.map((district) {
                      return DropdownMenuItem<String>(
                        value: district.code,
                        child: Text(district.fullName),
                      );
                    }).toList(),
                onChanged: (String? newCode) {
                  if (newCode != null) {
                    controller.selectedDistrictCode.value = newCode;
                    controller.getWards();
                  }
                },
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            "Phường xá",
            style: TextStyle(
              fontSize: 14.sp,
              color: Color(0xFF374151),
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 4.h),
          Obx(
            () => Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: DropdownButton<String>(
                value:
                    controller.selectedWardId.value.isEmpty
                        ? null
                        : controller.selectedWardId.value,
                hint: const Text("Phường, xá"),
                isExpanded: true,
                items:
                    controller.wards.map((district) {
                      return DropdownMenuItem<String>(
                        value: district.code,
                        child: Text(district.fullName),
                      );
                    }).toList(),
                onChanged: (String? newCode) {
                  if (newCode != null) {
                    controller.selectedWardId.value = newCode;
                  }
                },
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            "Tên đường",
            style: TextStyle(
              fontSize: 14.sp,
              color: Color(0xFF374151),
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: TextField(
              controller: controller.nameStress,
              decoration: InputDecoration(
                hintText: "Vd: Trần Phú",
                hintStyle: TextStyle(color: Colors.grey[500]),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            "Địa chỉ",
            style: TextStyle(
              fontSize: 14.sp,
              color: Color(0xFF374151),
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: TextField(
              controller: controller.address,
              decoration: InputDecoration(
                hintText: "Vd: 123",
                hintStyle: TextStyle(color: Colors.grey[500]),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            "Tiêu chí",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
              color: Colors.red,
            ),
          ),
          SizedBox(height: 8.h),
          GroupCheckbox(),
          SizedBox(height: 12.h),
          Text(
            "Tìm kiếm mở rộng",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
              color: Colors.red,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "Diện tích thực tế:",
            style: TextStyle(
              fontSize: 14.sp,
              color: Color(0xFF374151),
              fontWeight: FontWeight.normal,
            ),
          ),
          squareForm(
            minController: controller.minActualAreaSqm,
            maxController: controller.maxActualAreaSqm,
          ),
          SizedBox(height: 8.h),
          Text(
            "Số tầng:",
            style: TextStyle(
              fontSize: 14.sp,
              color: Color(0xFF374151),
              fontWeight: FontWeight.normal,
            ),
          ),
          squareForm(
            minController: controller.minNumberOfFloors,
            maxController: controller.maxNumberOfFloors,
          ),
          SizedBox(height: 8.h),
          SizedBox(height: 8.h),
          Text(
            "Mặt tiền:",
            style: TextStyle(
              fontSize: 14.sp,
              color: Color(0xFF374151),
              fontWeight: FontWeight.normal,
            ),
          ),
          squareForm(
            minController: controller.minFrontageMeters,
            maxController: controller.maxFrontageMeters,
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
            child: _buttonCustom(text: "Đặt lại", onTap: () {}),
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
