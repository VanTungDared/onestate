import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ConvertApp {
  static TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digitsOnly = newValue.text.replaceAll('.', '').replaceAll(',', '');

    if (digitsOnly.isEmpty) return newValue.copyWith(text: '');

    final number = int.tryParse(digitsOnly);
    if (number == null) return oldValue;

    final formatted = formatCurrencyVND(number);

    // Cập nhật vị trí con trỏ về cuối chuỗi
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  static String formatCurrencyVND(int amount) {
    final formatter = NumberFormat("#,###", "vi_VN");
    return formatter.format(amount);
  }
}

class VNDTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return ConvertApp.formatEditUpdate(oldValue, newValue);
  }
}
