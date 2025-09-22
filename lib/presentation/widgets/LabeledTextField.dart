import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LabeledTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final bool isRequired;
  final TextInputType keyboardType;
  final String? suffixText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;

  const LabeledTextField({
    Key? key,
    required this.label,
    this.hintText,
    this.isRequired = false,
    this.keyboardType = TextInputType.text,
    this.suffixText,
    this.onChanged,
    this.controller,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
        TextField(
          inputFormatters: inputFormatters,
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            suffixText: suffixText,
            isDense: true,
            hintStyle: TextStyle(color: Colors.grey),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 6,
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
      ],
    );
  }
}
