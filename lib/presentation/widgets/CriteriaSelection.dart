import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CriteriaSelection extends StatelessWidget {
  final String label;
  TextStyle? textStyle;
  final Map<String, String> options; // key = label, value = code
  final RxList<Map<String, dynamic>> selectedOptions;

  CriteriaSelection({
    super.key,
    required this.label,
    this.textStyle,
    required this.options,
    required this.selectedOptions,
  });

  @override
  Widget build(BuildContext context) {
    final optionLabels = options.keys.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
              textStyle ?? TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 4,
          ),
          itemCount: optionLabels.length,
          itemBuilder: (context, index) {
            final criteriaLabel = optionLabels[index];
            final criteriaValue = options[criteriaLabel]!;

            return Obx(() {
              final isSelected = selectedOptions.any(
                (item) => item["value"] == criteriaValue,
              );

              void toggleSelection(bool? val) {
                if (val == true) {
                  selectedOptions.add({
                    "label": criteriaLabel,
                    "value": criteriaValue,
                  });
                } else {
                  selectedOptions.removeWhere(
                    (item) => item["value"] == criteriaValue,
                  );
                }
              }

              return Row(
                children: [
                  Checkbox(value: isSelected, onChanged: toggleSelection),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        toggleSelection(
                          !isSelected,
                        ); // đảo ngược trạng thái khi bấm chữ
                      },
                      child: Text(
                        criteriaLabel,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ),
                  ),
                ],
              );
            });
          },
        ),
      ],
    );
  }
}
