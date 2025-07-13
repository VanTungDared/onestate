import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../main_controller.dart';

class GroupCheckboxTypeHouse extends GetView<MainController> {
  const GroupCheckboxTypeHouse({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: controller.typeHouse.length,
      itemBuilder: (context, index) {
        return Obx(() {
          final option = controller.typeHouse[index];
          final isSelected = controller.selectedTypeHouse.contains(
            option.label,
          );
          return CheckboxListTile(
            controlAffinity: ListTileControlAffinity.trailing,
            contentPadding: EdgeInsets.zero,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(option.icon, size: 16.w),
                SizedBox(width: 8.w),
                Text(option.label, style: TextStyle(fontSize: 14.sp)),
              ],
            ),
            value: isSelected,
            onChanged: (bool? isChecked) {
              if (isChecked == true) {
                controller.selectedTypeHouse.add(option.label);
              } else {
                controller.selectedTypeHouse.remove(option.label);
              }
            },
          );
        });
      },
      separatorBuilder: (_, __) => SizedBox(height: 2.h),
    );
  }
}
