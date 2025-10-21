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

  static Map<String, double>? extractLatLngFromGoogleMapsUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return null;

    final urlString = url;

    // 1️⃣ Ưu tiên tìm !3dLAT!4dLNG (thường là marker)
    final regExpMarker = RegExp(r'!3d(-?\d+\.\d+)!4d(-?\d+\.\d+)');
    final matchMarker = regExpMarker.firstMatch(urlString);
    if (matchMarker != null) {
      final lat = double.tryParse(matchMarker.group(1)!);
      final lng = double.tryParse(matchMarker.group(2)!);
      if (lat != null && lng != null) {
        return {'lat': lat, 'lng': lng};
      }
    }

    // 2️⃣ Fallback: tìm @LAT,LNG,ZOOM
    final regExpAt = RegExp(r'@(-?\d+\.\d+),(-?\d+\.\d+),');
    final matchAt = regExpAt.firstMatch(urlString);
    if (matchAt != null) {
      final lat = double.tryParse(matchAt.group(1)!);
      final lng = double.tryParse(matchAt.group(2)!);
      if (lat != null && lng != null) {
        return {'lat': lat, 'lng': lng};
      }
    }

    // 3️⃣ Fallback: query parameter q=LAT,LNG
    if (uri.queryParameters.containsKey('q')) {
      final parts = uri.queryParameters['q']!.split(',');
      if (parts.length >= 2) {
        final lat = double.tryParse(parts[0]);
        final lng = double.tryParse(parts[1]);
        if (lat != null && lng != null) {
          return {'lat': lat, 'lng': lng};
        }
      }
    }

    return null; // không tìm thấy
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
