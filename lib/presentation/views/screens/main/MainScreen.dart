import 'package:app_real_estate/presentation/views/screens/main/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'HomeScreen.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              onPageChanged: (index) {
                controller.indexPage.value = index;
              },
              controller: controller.pageController,
              children: [
                HomeScreen()
              ], // bạn thêm các page ở đây
            ),
          ),
        ],
      ),
    );
  }
}
