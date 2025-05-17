import 'package:app_real_estate/constants/color_constants.dart';
import 'package:app_real_estate/controllers/main_controller.dart';
import 'package:app_real_estate/views/screens/CategoryScreen.dart';
import 'package:app_real_estate/views/screens/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                // Gán cho GetX observable nếu dùng
                controller.indexPage.value = index;
              },
              controller: controller.pageController,
              children: [
                // Obx(() {
                //   if (controller.countRender.value > 0) {
                //     return HomeScreen(dataListings: controller.dataListings);
                //   } else {
                //     return HomeScreen(dataListings: controller.dataListings);
                //   }
                // }),
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
                ProfileScreen(),
              ], // bạn thêm các page ở đây
            ),
          ),

          // 🔹 Bottom bar cố định
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Colors.black12,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children:
                  controller.bottomItems.asMap().entries.map((entry) {
                    int index = entry.key;
                    var item = entry.value;
                    return Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.indexPage.value = index;
                          controller.pageController.jumpToPage(index);
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(
                              () => SvgPicture.asset(
                                controller.indexPage.value == index
                                    ? item['iconActive']
                                    : item['icon'],
                                width: 24,
                                height: 24,
                              ),
                            ),
                            SizedBox(height: 4),
                            Obx(
                              () => Text(
                                item['label'],
                                style:
                                    controller.indexPage.value == index
                                        ? TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: ColorConstant.greenColor,
                                        )
                                        : TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
