import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../filter_controller.dart';

class GroupCheckbox extends GetView<FilterController> {
  const GroupCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160.h,
      child: Obx(
            () => GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 4,
          children: controller.options.map((option) {
            final isSelected = controller.selectedItems.contains(option);
            return CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              title: Text(option),
              value: isSelected,
              onChanged: (bool? isChecked) {
                if (isChecked == true) {
                  controller.selectedItems.add(option);
                } else {
                  controller.selectedItems.remove(option);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
