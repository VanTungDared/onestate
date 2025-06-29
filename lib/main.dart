import 'package:app_real_estate/app.dart';
import 'package:app_real_estate/presentation/views/app/app_controller.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppController.init();
  runApp(MyApp());
}
