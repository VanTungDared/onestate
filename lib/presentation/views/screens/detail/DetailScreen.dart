import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/constants/api_url.dart';
import '../../../../core/utils/constants/asset_constants.dart';
import 'detail_controller.dart';
import '../../../widgets/ButtonPrimary.dart';

class DetailScreen extends GetView<DetailController> {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final item = controller.listingDetail.value;
        if (item == null) {
          return const SizedBox.shrink();
        }
        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 256.h,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 1.0,
                      aspectRatio: 16 / 9,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                    ),
                    items:
                        item.imageUrls.map((url) {
                          return Builder(
                            builder: (BuildContext context) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CachedNetworkImage(
                                  imageUrl: "${ApiUrl.baseUrlImage}/$url",
                                  placeholder:
                                      (context, url) =>
                                          const CircularProgressIndicator(),
                                  errorWidget:
                                      (context, url, error) =>
                                          const Icon(Icons.error),
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          );
                        }).toList(),
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                    child: Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(height: 32.h, color: Colors.grey.shade300),
                  // Info: Giá - Diện tích - Số tầng - Trạng thái
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _infoItem(
                          "Mức giá",
                          _formatCurrency(item.listingPriceVndSell),
                        ),
                        _infoItem("Diện tích", "${item.actualAreaSqm} m²"),
                        _infoItem("Số tầng", "${item.numberOfFloors}"),
                        _statusTag(item.status, "Trạng thái"),
                      ],
                    ),
                  ),
                  Divider(height: 32.h, color: Colors.grey.shade300),
                  // Thông tin mô tả
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Thông tin mô tả",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                    child: Text(item.description),
                  ),

                  SizedBox(height: 16.h),

                  // Buttons
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _actionButton(Icons.share, "Chia sẻ"),
                        SizedBox(width: 12.w),
                        _actionButton(Icons.report, "Báo xấu"),
                        SizedBox(width: 12.w),
                        Obx(
                          () => _actionButton(
                            controller.isLiked.value
                                ? Icons.favorite
                                : Icons.favorite_border,
                            "",
                            callBack: () => controller.handleLikeListing(),
                            color: controller.isLiked.value ? Colors.red : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  // Thông số kỹ thuật
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Thông số kỹ thuật",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Divider(height: 12.h, color: Colors.grey.shade300),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        _techInfoRow(
                          "Diện tích sổ",
                          "${item.legalAreaSqm} m²",
                          "assets/images/icon_dientich_so.png",
                        ),
                        Divider(height: 12.h, color: Colors.grey.shade300),
                        _techInfoRow(
                          "Thực tế",
                          "${item.actualAreaSqm} m²",
                          "assets/images/icon_dientich_so.png",
                        ),
                        Divider(height: 12.h, color: Colors.grey.shade300),
                        _techInfoRow(
                          "Mặt tiền",
                          "${item.frontageMeters} m",
                          Icons.home_outlined,
                        ),
                        Divider(height: 12.h, color: Colors.grey.shade300),
                        _techInfoRow(
                          "Chiều sâu",
                          "${item.widthMeters} m",
                          CupertinoIcons.square_on_square,
                        ),
                        Divider(height: 12.h, color: Colors.grey.shade300),
                        _techInfoRow(
                          "Đường trước nhà",
                          "-",
                          "assets/images/icon_road.png",
                        ),
                        Divider(height: 12.h, color: Colors.grey.shade300),
                        _techInfoRow(
                          "Số tầng",
                          "${item.numberOfFloors} tầng",
                          "assets/images/icon_thang.png",
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Thông tin giá tiền
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Thông tin giá tiền",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Divider(height: 12.h, color: Colors.grey.shade300),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        _techInfoRow(
                          "Giá chào",
                          _formatCurrency(item.listingPriceVndSell),
                          Icons.money,
                        ),
                        Divider(height: 12.h, color: Colors.grey.shade300),
                        _techInfoRow(
                          "Trích thưởng",
                          "${item.commissionRatePercent}% - ${_formatCurrency(item.commissionAmountVnd)}",
                          Icons.monetization_on,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Thông tin người đăng
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Thông tin người đăng",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 16.r,
                              backgroundColor: Colors.red,
                              child: Text(
                                (item.authorName.isNotEmpty)
                                    ? item.authorName[0].toUpperCase()
                                    : '',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Người đăng",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  item.authorName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            Icon(Icons.phone, size: 32.w),
                            SizedBox(width: 12.w),
                            Column(
                              children: [
                                Text(
                                  "Số điện thoại",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  item.phoneNumber,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Thông tin chủ nhà
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Thông tin chủ nhà",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.pink,
                              child: Text(
                                (item.ownerName.isNotEmpty)
                                    ? item.ownerName[0].toUpperCase()
                                    : '',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Chủ nhà",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  item.ownerName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Khu vực
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Khu vực",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        _locationItem("Tỉnh/Thành phố", item.province.name),
                        _locationItem("Quận/Huyện", item.district.name),
                        _locationItem("Phường/Xã", item.ward.name),
                        _locationItem("Địa chỉ", item.fullAddress),
                      ],
                    ),
                  ),
                  SizedBox(height: 68.h),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0.h,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1.w, color: Colors.grey),
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 20.r,
                      backgroundColor: Colors.red,
                      child: Text(
                        item.authorName[0].toUpperCase(),
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ),
                    ),
                    ButtonPrimary(
                      content: "Zalo",
                      icon: Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: SvgPicture.asset(
                          AssetConstant.logoZalo,
                          height: 24.h,
                        ),
                      ),
                      horizontalPadding: 16.w,
                      verticalPadding: 4.h,
                      callBack: () async {
                        final url = Uri.parse(
                          'https://zalo.me/${item.phoneNumber}',
                        );
                        if (await canLaunchUrl(url)) {
                          await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          );
                        } else {
                          throw 'Không thể mở đường dẫn: $url';
                        }
                      },
                      boxBorder: Border.all(width: 1.w, color: Colors.grey),
                    ),
                    ButtonPrimary(
                      content: item.phoneNumber,
                      icon: Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: Icon(Icons.phone, color: Colors.white),
                      ),
                      horizontalPadding: 16.w,
                      verticalPadding: 8.h,
                      color: Color(0xff00A5AB),
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                      callBack: () async {
                        final url = Uri.parse('tel:${item.phoneNumber}');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          );
                        } else {
                          throw 'Không thể mở đường dẫn: $url';
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _infoItem(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
        SizedBox(height: 2.h),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _statusTag(String status, String label) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
        SizedBox(height: 2.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: status == "approved" ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            status == "approved" ? "Đã duyệt" : "Chờ duyệt",
            style: TextStyle(color: Colors.white, fontSize: 12.sp),
          ),
        ),
      ],
    );
  }

  Widget _actionButton(
    IconData icon,
    String label, {
    VoidCallback? callBack,
    Color? color,
  }) {
    return GestureDetector(
      onTap: callBack ?? () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color ?? Colors.black, size: 18.sp),
            if (label.isNotEmpty) ...[
              SizedBox(width: 6.w),
              Text(label, style: TextStyle(fontSize: 13.sp)),
            ],
          ],
        ),
      ),
    );
  }

  String _formatCurrency(String? vnd) {
    if (vnd == null) return "";
    final value = double.tryParse(vnd);
    if (value == null) return "N/A";
    if (value >= 1000000000) {
      return "${(value / 1000000000).toStringAsFixed(0)} tỷ";
    } else if (value >= 1000000) {
      return "${(value / 1000000).toStringAsFixed(0)} triệu";
    }
    return "$value đ";
  }

  Widget _techInfoRow(String label, String value, dynamic iconOrImage) {
    Widget iconWidget;

    if (iconOrImage is IconData) {
      iconWidget = Icon(iconOrImage, size: 24.w, color: Colors.black54);
    } else if (iconOrImage is String) {
      iconWidget = Image.asset(
        iconOrImage,
        width: 24.w,
        height: 24.w,
        errorBuilder:
            (context, error, stackTrace) =>
                Icon(Icons.image_not_supported, size: 24.w),
        color: Colors.black54,
      );
    } else {
      iconWidget = SizedBox(width: 24.w);
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          iconWidget,
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                value,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _criterionChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_box, size: 16, color: Colors.black54),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _locationItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
        SizedBox(height: 4.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey)),
          ),
          child: Text(
            value.isEmpty ? "Chưa có địa chỉ" : value,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
          ),
        ),
        SizedBox(height: 12.h),
      ],
    );
  }
}
