import 'package:app_real_estate/core/utils/image_utils.dart';
import 'package:app_real_estate/presentation/views/screens/my_favourite/my_favourite_controller.dart';
import 'package:app_real_estate/presentation/widgets/InfoCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/utils/constants/asset_constants.dart';

class MyFavoutiteScreen extends GetView<MyFavouriteController> {
  const MyFavoutiteScreen({super.key}); // sửa lại constructor
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true, // giữ cho title căn giữa
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text("Bài Đăng Yêu Thích"),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Center(
              child: ImageUtils.loadFromAsset(
                AssetConstant.logoPng,
                height: 32.h,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Danh sách
            Expanded(
              child: Obx(() {
                final isLoading = controller.isLoadingListing.value;
                final hasMore =
                    controller.currentPage.value < controller.lastPage.value;
                final totalItems = controller.dataListings.length;
                return ListView.builder(
                  controller: controller.scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: totalItems + 1,
                  itemBuilder: (context, index) {
                    if (index < totalItems) {
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
                          onPress: () => controller.onPressCard(id: item.id),
                          listingPriceVndRent: _formatPrice(
                            item.listingPriceVndRent.toString(),
                          ),
                          legalAreaSqm: item.legalAreaSqm.toString(),
                          province: item.province.name,
                          district: item.district.name,
                          own: item.authorName,
                          updatedAt: formatUpdatedAtDaysAgo(item.updatedAt),
                        ),
                      );
                    } else {
                      if (isLoading) {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else if (!hasMore) {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(
                            child: Text(
                              "Đã tải hết dữ liệu",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    }
                  },
                );
              }),
            ),
          ],
        ),
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
