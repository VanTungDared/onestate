import 'package:app_real_estate/app.dart';
import 'package:flutter/material.dart';

import 'core/utils/app_translation.dart';
import 'data/datasources/dblocal/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppTranslations.loadTranslations();
  await SharedPreferenceApp.init();
  runApp(MyApp());
}
