import 'package:app_real_estate/app.dart';
import 'package:app_real_estate/presentation/views/app/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await AppController.init();
  runApp(MyApp());
}
