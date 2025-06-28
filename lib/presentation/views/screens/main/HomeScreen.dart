import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../routers/routerName.dart';
import '../../../widgets/InfoCard.dart';
import 'main_controller.dart';

class HomeScreen extends GetView<MainController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouterName.search);
                  },
                  child: Container(
                    height: 46.h,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            'Tìm kiếm bằng từ khóa',
                            style: TextStyle(color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(Icons.tune, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(
                      () => Text(
                        'Có ${controller.dataListings.length} bất động sản',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    _sortWidget(),
                  ],
                ),
                SizedBox(height: 16.h),

                Obx(
                  () => ListView.builder(
                    itemCount: controller.dataListings.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = controller.dataListings[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: InfoCard(
                          imageUrl:
                              item.imageUrls.isNotEmpty
                                  ? item.imageUrls.first
                                  : 'https://via.placeholder.com/150',
                          title: item.title,
                          description: item.description,
                          onPress: () {
                            controller.onPressCard(id: item.id);
                          },
                          listingPriceVndRent: _formatPrice(
                            item.listingPriceVndRent,
                          ),
                          legalAreaSqm: item.legalAreaSqm,
                          province: item.province.name,
                          district: item.district.name,
                          own: item.authorName,
                          updatedAt: formatUpdatedAtDaysAgo(item.updatedAt),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sortWidget() {
    return Container(
      height: 32.h,
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(width: 1.w, color: Colors.grey),
      ),
      child: Row(
        children: [
          Text(
            "Tin mới nhất (Mặc định) ",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
              color: Color(0xFF6B7280),
            ),
          ),
          Icon(Icons.arrow_drop_down, color: Color(0xFF6B7280)),
        ],
      ),
    );
  }

  String _formatPrice(String? priceVnd) {
    if (priceVnd == null) return 'Đang cập nhật';
    try {
      double price = double.parse(priceVnd);
      if (price >= 1000000000) {
        return '${(price / 1000000000).toStringAsFixed(1)} tỷ';
      } else if (price >= 1000000) {
        return '${(price / 1000000).toStringAsFixed(1)} triệu';
      } else {
        return '${price.toStringAsFixed(0)} đ';
      }
    } catch (e) {
      return 'Đang cập nhật';
    }
  }

  String formatUpdatedAtDaysAgo(DateTime? updatedAt) {
    if (updatedAt == null) return 'Đang cập nhật';

    final now = DateTime.now();
    final difference = now.difference(updatedAt).inDays;

    if (difference == 0) {
      return 'Cập nhật hôm nay';
    } else if (difference == 1) {
      return 'Cập nhật hôm qua';
    } else {
      return 'Cập nhật $difference ngày trước';
    }
  }
}
