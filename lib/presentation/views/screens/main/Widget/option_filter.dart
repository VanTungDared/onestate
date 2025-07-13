import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../routers/routerName.dart';

class OptionFilter extends StatelessWidget {
  const OptionFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(RouterName.filter);
          },
          child: Container(
            height: 32.h,
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
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
        Container(
          height: 32.h,
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 12.w),
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
              Icon(Icons.arrow_drop_down, size: 20.w, color: Color(0xFF6B7280)),
            ],
          ),
        ),
        Container(
          height: 32.h,
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 12.w),
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
              Icon(Icons.arrow_drop_down, size: 20.w, color: Color(0xFF6B7280)),
            ],
          ),
        ),
      ],
    );
  }
}
