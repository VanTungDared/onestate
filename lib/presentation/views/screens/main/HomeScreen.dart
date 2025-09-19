import 'package:app_real_estate/core/utils/constants/asset_constants.dart';
import 'package:app_real_estate/core/utils/image_utils.dart';
import 'package:app_real_estate/presentation/widgets/CustomDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widgets/InfoCard.dart';
import 'Widget/custom_check_box.dart';
import 'Widget/option_filter.dart';
import 'main_controller.dart';

class HomeScreen extends GetView<MainController> {
  HomeScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Obx(
        () =>
            controller.userModel.value != null
                ? CustomDrawer(
                  userModel: controller.userModel.value!,
                  scaffoldKey: _scaffoldKey,
                  callLogout: () => controller.handleCallLogout(),
                )
                : SizedBox(),
      ),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        actionsPadding: EdgeInsets.symmetric(horizontal: 16.w),
        actions: [
          ImageUtils.loadFromAsset(AssetConstant.logoTop),
          Spacer(),
          GestureDetector(
            onTap: () => _scaffoldKey.currentState?.openEndDrawer(),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 10, 0, 10),
              child: Icon(Icons.menu),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          final isLoading = controller.isLoadingListing.value;
          final hasMore =
              controller.currentPage.value < controller.lastPage.value;
          final totalItems = controller.dataListings.length;
          return Column(
            children: [
              // Header cố định
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.search, color: Colors.grey),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: TextField(
                                controller: controller.controllerSearch,
                                onChanged:
                                    (val) => controller.keyword.value = val,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 8.h,
                                  ),
                                  isDense: true,
                                  border: InputBorder.none,
                                  hint: Text(
                                    "Tìm kiếm bằng từ khóa",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    OptionFilter(),
                    SizedBox(height: 6.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Số lượng: $totalItems',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        _sortWidget(context),
                      ],
                    ),
                    SizedBox(height: 6.h),
                  ],
                ),
              ),

              // Danh sách cuộn
              Expanded(
                child: ListView.builder(
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
                            item.listingPriceVndSell.toString(),
                          ),
                          legalAreaSqm: formatDouble(item.legalAreaSqm),
                          province: item.province.name,
                          district: item.district.name,
                          own: item.authorName,
                          updatedAt: formatUpdatedAtDaysAgo(item.updatedAt),
                          isLiked: item.isLiked,
                          onPressFavourite:
                              () => controller.handleFavourite(index, item.id),
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
                ),
              ),
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
        height: 28.h,
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 8.w),
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.normal,
                color: const Color(0xFF6B7280),
              ),
            ),
            const Icon(Icons.arrow_drop_down, color: Color(0xFF6B7280)),
          ],
        ),
      ),
    );
  }

  String _formatPrice(String? priceVnd) {
    if (priceVnd == null) return 'Đang cập nhật';
    try {
      double price = double.parse(priceVnd);

      String formatNumber(double value, double divisor, String unit) {
        String result = (value / divisor).toStringAsFixed(1);
        // Nếu có .0 thì bỏ đi
        result = result.replaceAll(RegExp(r'\.0$'), '');
        return '$result $unit';
      }

      if (price >= 1000000000) {
        return formatNumber(price, 1000000000, 'tỷ');
      } else if (price >= 1000000) {
        return formatNumber(price, 1000000, 'triệu');
      } else {
        String result = price.toStringAsFixed(0);
        return '$result đ';
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

  void showBottomDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
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

  String formatDouble(double value) {
    if (value % 1 == 0) {
      // nếu không có phần thập phân
      return value.toInt().toString();
    } else {
      return value.toString();
    }
  }
}
