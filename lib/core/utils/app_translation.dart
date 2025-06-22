import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {};

  static Future<void> loadTranslations() async {
    final languages = ['vi', 'en'];
    final translations = <String, Map<String, String>>{};

    for (var lang in languages) {
      final jsonString = await rootBundle.loadString(
        'assets/translations/$lang.json',
      );
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      translations[lang] = jsonMap.map(
        (key, value) => MapEntry(key, value.toString()),
      );
    }

    Get.addTranslations(translations);
  }
}
