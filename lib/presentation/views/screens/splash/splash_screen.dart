import 'package:app_real_estate/core/utils/constants/asset_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/app_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initApp();
  }

  Future<void> initApp() async {
    final controller = Get.find<AppController>();
    await AppController.init();
    controller.handleNavigation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AssetConstant.logoApp,
          width: 150,
          height: 150,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
