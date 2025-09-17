import 'package:flutter/material.dart';

class LabeledMultilineTextField extends StatelessWidget {
  final String label;
  final bool isRequired;
  final String? hintText;
  final int minLines;
  final int maxLines;
  final String? helperText;
  final ValueChanged<String>? onChanged;

  const LabeledMultilineTextField({
    Key? key,
    required this.label,
    this.isRequired = false,
    this.hintText,
    this.minLines = 4,
    this.maxLines = 6,
    this.helperText,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            children: [
              if (isRequired)
                const TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          minLines: minLines,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText ?? '',
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8,
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
          onChanged: onChanged,
        ),
        if (helperText != null) ...[
          const SizedBox(height: 4),
          Text(
            helperText!,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ],
    );
  }
}
