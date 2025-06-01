import 'package:app_real_estate/controllers/main_controller.dart';
import 'package:app_real_estate/views/screens/CategoryScreen.dart';
import 'package:app_real_estate/views/screens/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  final controller = Get.put(MainController());

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 🔹 Dành toàn bộ phần còn lại cho PageView
          Expanded(
            child: PageView(
              onPageChanged: (index) {
                print("Đã chuyển sang trang: $index");
                controller.indexPage.value = index;
              },
              controller: controller.pageController,
              children: [
                Obx(() {
                  if (controller.countRender.value > 0) {
                    return CategoryScreen(
                      dataListings: controller.dataListings,
                    );
                  } else {
                    return CategoryScreen(
                      dataListings: controller.dataListings,
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
