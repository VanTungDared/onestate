import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class LabeledDropdown<T> extends StatelessWidget {
  final String label;
  final bool isRequired;
  final String? hintText;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;

  const LabeledDropdown({
    Key? key,
    required this.label,
    this.isRequired = false,
    this.hintText,
    required this.items,
    this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseStyle = Theme.of(context).textTheme.bodyMedium;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        RichText(
          text: TextSpan(
            text: label,
            style: baseStyle?.copyWith(
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
            children:
                isRequired
                    ? [
                      const TextSpan(
                        text: " *",
                        style: TextStyle(color: Colors.red),
                      ),
                    ]
                    : [],
          ),
        ),
        const SizedBox(height: 6),
        // Dropdown đẹp hơn với dropdown_button2
        DropdownButtonFormField2<T>(
          value: value,
          onChanged: onChanged,
          items: items,
          isExpanded: true,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue, width: 1.2),
            ),
          ),

          // 👇 Chuyển hintText sang đây
          hint: Text(
            hintText ?? "",
            style: const TextStyle(color: Colors.grey),
          ),

          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.only(right: 8),
            height: 40,
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.black54,
            ),
            iconSize: 22,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
