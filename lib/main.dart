import 'package:app_real_estate/app.dart';
import 'package:flutter/material.dart';

import 'core/utils/app_translation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppTranslations.loadTranslations();
  runApp(MyApp());
}
