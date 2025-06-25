import 'package:app_real_estate/presentation/views/screens/main/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../CategoryScreen.dart';

class MainScreen extends GetView<MainController> {


  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 🔹 Dành toàn bộ phần còn lại cho PageView
          Expanded(
            child: PageView(
              onPageChanged: (index) {
                controller.indexPage.value = index;
              },
              controller: controller.pageController,
              children: [
                Obx(() {
                  if (controller.countRender.value > 0) {
                    return CategoryScreen(
                      dataListings: controller.dataListings,
                      userModel: controller.userModel,
                    );
                  } else {
                    return CategoryScreen(
                      dataListings: controller.dataListings,
                      userModel: controller.userModel,
                    );
                  }
                }),
              ], // bạn thêm các page ở đây
            ),
          ),
        ],
      ),
    );
  }
}
