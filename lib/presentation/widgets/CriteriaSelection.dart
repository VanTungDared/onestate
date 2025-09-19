import 'package:app_real_estate/data/models/option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CriteriaSelection extends StatelessWidget {
  final String label;
  final TextStyle? textStyle;
  final List<OptionModel> options;
  final RxList<OptionModel> selectedOptions;

  const CriteriaSelection({
    super.key,
    required this.label,
    this.textStyle,
    required this.options,
    required this.selectedOptions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
              textStyle ??
              const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
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
          itemCount: options.length,
          itemBuilder: (context, index) {
            final option = options[index];

            return Obx(() {
              final isSelected = selectedOptions.contains(option);

              void toggleSelection(bool? val) {
                if (val == true) {
                  selectedOptions.add(option);
                } else {
                  selectedOptions.remove(option);
                }
              }

              return Row(
                children: [
                  Checkbox(value: isSelected, onChanged: toggleSelection),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => toggleSelection(!isSelected),
                      child: Text(
                        option.label,
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
