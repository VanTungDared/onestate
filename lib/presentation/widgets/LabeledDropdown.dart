import 'package:flutter/material.dart';

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
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            children:
                isRequired
                    ? [
                      TextSpan(text: " *", style: TextStyle(color: Colors.red)),
                    ]
                    : [],
          ),
        ),
        const SizedBox(height: 6),

        // Dropdown
        DropdownButtonFormField<T>(
          value: value,
          onChanged: onChanged,
          items: items,
          decoration: InputDecoration(
            hintText: hintText,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.blue, width: 1.2),
            ),
          ),
        ),
      ],
    );
  }
}
