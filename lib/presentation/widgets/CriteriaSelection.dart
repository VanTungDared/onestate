import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CriteriaSelection extends StatelessWidget {
  final String label;
  final List<String> options;
  final RxList<String> selectedOptions;

  const CriteriaSelection({
    Key? key,
    required this.label,
    required this.options,
    required this.selectedOptions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 cột
            childAspectRatio: 4, // tỉ lệ chiều ngang/dọc
            crossAxisSpacing: 8,
            mainAxisSpacing: 4,
          ),
          itemCount: options.length,
          itemBuilder: (context, index) {
            final criteria = options[index];
            return Obx(() {
              final isSelected = selectedOptions.contains(criteria);
              return Row(
                children: [
                  Checkbox(
                    value: isSelected,
                    onChanged: (val) {
                      if (val == true) {
                        selectedOptions.add(criteria);
                      } else {
                        selectedOptions.remove(criteria);
                      }
                    },
                  ),
                  Expanded(
                    child: Text(criteria, overflow: TextOverflow.ellipsis),
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
