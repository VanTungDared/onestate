import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCheckboxRow extends StatelessWidget {
  final String title;
  final bool isChecked;
  final ValueChanged<bool> onChanged;

  const CustomCheckboxRow({
    super.key,
    required this.title,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF374151),
          ),
        ),
        InkWell(
          onTap: () => onChanged(!isChecked),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: isChecked ? Colors.blue : Colors.grey,
                width: isChecked ? 5.w : 1.w,
              ),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
