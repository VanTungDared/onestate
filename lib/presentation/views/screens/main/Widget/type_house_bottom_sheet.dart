import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'group_type_house.dart';

void showBottomDialog({
  required BuildContext context,
  required VoidCallback showResult,
  required VoidCallback reset
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      final halfScreenHeight = MediaQuery.of(context).size.height * 0.7;
      return Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: halfScreenHeight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Loại nhà đất",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.close, size: 24.w, color: Colors.grey),
                  ),
                ],
              ),
              Divider(color: Colors.grey, height: 24.h),
              Expanded(child: GroupCheckboxTypeHouse()),
              SizedBox(height: 12.h),
              buttonFilter(showResult: showResult, reset: reset),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      );
    },
  );
}

Widget buttonFilter({required VoidCallback showResult,required VoidCallback reset}) {
  return Container(
    width: Get.width,
    padding: EdgeInsets.only(top: 8.h),
    child: Row(
      children: [
        Flexible(flex: 1, child: _buttonCustom(text: "Đặt lại", onTap: reset)),
        SizedBox(width: 12.w),
        Flexible(
          flex: 2,
          child: _buttonCustom(
            text: "Xem kết quả",
            bgColor: Colors.redAccent,
            textColor: Colors.white,
            borderSideColor: Colors.redAccent,
            onTap: showResult,
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
