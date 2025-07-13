import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../routers/routerName.dart';
import '../../../widgets/InfoCard.dart';
import 'Widget/custom_check_box.dart';
import 'Widget/option_filter.dart';
import 'main_controller.dart';

class HomeScreen extends GetView<MainController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          final isLoading = controller.isLoadingListing.value;
          final hasMore =
              controller.currentPage.value < controller.lastPage.value;
          final totalItems = controller.dataListings.length;

          return CustomScrollView(
            controller: controller.scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Get.toNamed(RouterName.search),
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
                      SizedBox(height: 12.h),
                      OptionFilter(),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Có $totalItems bất động sản',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          _sortWidget(context),
                        ],
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),

              // Danh sách bất động sản
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
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
                            item.listingPriceVndRent,
                          ),
                          legalAreaSqm: item.legalAreaSqm,
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
                  }, childCount: totalItems + 1),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 12)),
            ],
          );
        }),
      ),
    );
  }

  Widget _sortWidget(BuildContext context) {
    String title = switch (controller.selectedSortOption.value) {
      SortOption.newest => 'Tin mới nhất (Mặc định)',
      SortOption.priceLowToHigh => 'Giá thấp đến cao',
      SortOption.priceHighToLow => 'Giá cao đến thấp',
      SortOption.areaSmallToLarge => 'Diện tích nhỏ đến lớn',
      SortOption.areaLargeToSmall => 'Diện tích lớn đến nhỏ',
    };
    return GestureDetector(
      onTap: () {
        showBottomDialog(context);
      },
      child: Container(
        height: 32.h,
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(width: 1.w, color: Colors.grey),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.normal,
                color: Color(0xFF6B7280),
              ),
            ),
            Icon(Icons.arrow_drop_down, color: Color(0xFF6B7280)),
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
    final difference = now
        .difference(updatedAt)
        .inDays;

    if (difference == 0) {
      return 'Cập nhật hôm nay';
    } else if (difference == 1) {
      return 'Cập nhật hôm qua';
    } else {
      return 'Cập nhật $difference ngày trước';
    }
  }

  void showBottomDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sắp xếp",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.close, size: 24.w, color: Colors.grey),
                  ),
                ],
              ),
              Divider(color: Colors.grey, height: 24.h),
              CustomCheckboxRow(
                title: 'Tin mới nhất (Mặc định)',
                isChecked:
                controller.selectedSortOption.value == SortOption.newest,
                onChanged: (bool value) {
                  controller.selectedSortOption.value = SortOption.newest;
                  controller.sortListings();
                  Get.back();
                },
              ),
              SizedBox(height: 24.h),
              CustomCheckboxRow(
                title: 'Giá thấp đến cao',
                isChecked:
                controller.selectedSortOption.value ==
                    SortOption.priceLowToHigh,
                onChanged: (bool value) {
                  controller.selectedSortOption.value =
                      SortOption.priceLowToHigh;
                  controller.sortListings();
                  Get.back();
                },
              ),
              SizedBox(height: 24.h),
              CustomCheckboxRow(
                title: 'Giá cao đến thấp',
                isChecked:
                controller.selectedSortOption.value ==
                    SortOption.priceHighToLow,
                onChanged: (bool value) {
                  controller.selectedSortOption.value =
                      SortOption.priceHighToLow;
                  controller.sortListings();
                  Get.back();
                },
              ),
              SizedBox(height: 24.h),
              CustomCheckboxRow(
                title: 'Diện tích nhỏ đến lớn',
                isChecked:
                controller.selectedSortOption.value ==
                    SortOption.areaSmallToLarge,
                onChanged: (bool value) {
                  controller.selectedSortOption.value =
                      SortOption.areaSmallToLarge;
                  controller.sortListings();
                  Get.back();
                },
              ),
              SizedBox(height: 24.h),
              CustomCheckboxRow(
                title: 'Diện tích lớn đến nhỏ',
                isChecked:
                controller.selectedSortOption.value ==
                    SortOption.areaLargeToSmall,
                onChanged: (bool value) {
                  controller.selectedSortOption.value =
                      SortOption.areaLargeToSmall;
                  controller.sortListings();
                  Get.back();
                },
              ),
              SizedBox(height: 100.h),
            ],
          ),
        );
      },
    );
  }
}
