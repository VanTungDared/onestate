import 'package:app_real_estate/presentation/views/screens/main/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'type_house_bottom_sheet.dart';
import 'type_price_bottom_sheet.dart';

class OptionFilter extends GetView<MainController> {
  const OptionFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: controller.goToFilterScreen,
          child: Container(
            height: 32.h,
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(width: 1.w, color: Colors.grey),
            ),
            child: Row(
              children: [
                Icon(Icons.filter_alt_outlined, size: 20.w),
                SizedBox(width: 8.w),
                Text(
                  'Lọc',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 4.w),
        GestureDetector(
          onTap: () {
            showBottomDialog(
              context: context,
              showResult: controller.filterByTypeHouse,
              reset: controller.resetTypeHouse,
            );
          },
          child: Container(
            height: 32.h,
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 10.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(width: 1.w, color: Colors.grey),
            ),
            child: Row(
              children: [
                Text(
                  'Loại nhà đất',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6B7280),
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.arrow_drop_down,
                  size: 20.w,
                  color: Color(0xFF6B7280),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 4.w),
        GestureDetector(
          onTap: () {
            showBottomDialogTypePrice(
              context,
              controller.minPrice,
              controller.maxPrice,
              showResult: controller.filterByTypePrice,
              reset: controller.resetTypePrice,
            );
          },
          child: Container(
            height: 32.h,
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 10.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(width: 1.w, color: Colors.grey),
            ),
            child: Row(
              children: [
                Text(
                  'Mức giá',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6B7280),
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.arrow_drop_down,
                  size: 20.w,
                  color: Color(0xFF6B7280),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
