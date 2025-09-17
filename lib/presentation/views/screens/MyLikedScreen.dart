import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/utils/constants/asset_constants.dart';
import '../../controllers/my-liked-controller.dart';
import '../../routers/routerName.dart';
import '../../widgets/SubImagesRow.dart';

class MyLikedScreen extends StatelessWidget {
  const MyLikedScreen({super.key}); // sửa lại constructor
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyLikedController());
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    if (controller.countRender.value == 0) return SizedBox();
    return Scaffold(
      key: scaffoldKey,
      endDrawer: Drawer(
        elevation: 0, // Tùy chọn, loại bỏ đổ bóng
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ), // Không bo góc
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.red,
                      child: Text(
                        'L', // hoặc tên viết tắt
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.userModel!.fullName,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            controller.userModel!.phoneNumber,
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.logout_outlined, color: Colors.red),
                      onPressed: () {
                        Get.offAllNamed(
                          RouterName.login,
                        ); // ví dụ chuyển về màn login
                      },
                    ),
                  ],
                ),
              ),
              // Đăng tin Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      'Đăng tin',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Divider(height: 1),
              ),

              // Danh sách tin
              ListTile(
                leading: Icon(Icons.article_outlined),
                title: Text('Danh sách tin của tôi'),
                tileColor: Colors.red,
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Divider(height: 1),
              ),

              // Yêu thích
              ListTile(
                leading: Icon(Icons.favorite_border),
                title: Text('Danh sách tin tôi yêu thích'),
                onTap: () {
                  // TODO: Navigate to favorites
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header: Logo + menu
                  ClipRect(
                    child: Obx(
                      () => Opacity(
                        opacity: controller.opacityHeader.value,
                        child: SizedBox(
                          height: controller.heightHeader.value,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_back_sharp),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                              SvgPicture.asset(AssetConstant.logo, width: 40),
                              IconButton(
                                icon: Icon(Icons.menu),
                                onPressed: () {
                                  scaffoldKey.currentState?.openEndDrawer();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Search box
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(RouterName.search);
                          },
                          child: Container(
                            height: 46,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Tìm kiếm bất động sản',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ClipRect(
                        child: Obx(
                          () => Opacity(
                            opacity: controller.opacityIcon.value,
                            child: SizedBox(
                              width: controller.widthIcon.value,
                              child: IconButton(
                                icon: Icon(Icons.menu),
                                onPressed: () {
                                  // Xử lý mở menu
                                  scaffoldKey.currentState?.openEndDrawer();
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                ],
              ),

              /// Danh sách
              Expanded(
                child: ListView.builder(
                  controller: controller.scrollController,
                  itemCount: controller.dataListings?.length ?? 0,
                  itemBuilder: (context, index) {
                    final listing =
                        controller.dataListings![index]; // lấy ListingModel
                    return GestureDetector(
                      onTap:
                          () => Get.toNamed(
                            RouterName.detail,
                            arguments: listing.id,
                          ),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              // ignore: deprecated_member_use
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Ảnh và nút yêu thích
                            Column(
                              children: [
                                /// Ảnh chính
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                  child: CachedNetworkImage(
                                    // imageUrl: controller.apiClient.getFullUrl(
                                    //   (listing.imageUrls.isNotEmpty)
                                    //       ? listing.imageUrls.first
                                    //       : 'https://via.placeholder.com/150',
                                    // ),
                                    imageUrl: 'https://via.placeholder.com/150',
                                    placeholder:
                                        (context, url) => Center(
                                          child:
                                              const CircularProgressIndicator(),
                                        ),
                                    errorWidget:
                                        (context, url, error) =>
                                            const Icon(Icons.error),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 210,
                                  ),
                                ),
                                SizedBox(height: 6),

                                /// Ảnh phụ
                                if (listing.imageUrls.length > 1)
                                  SubImagesRow(
                                    imageUrls: listing.imageUrls.sublist(1),
                                    controller: controller,
                                  ),
                              ],
                            ),

                            /// Nội dung bên dưới
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title
                                  Text(
                                    listing.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 8),

                                  // Giá + Diện tích
                                  Row(
                                    children: [
                                      Text(
                                        _formatPrice(
                                          listing.listingPriceVndRent
                                              .toString(),
                                        ),
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        '${listing.legalAreaSqm}m²',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.blue[50],
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        child: Text(
                                          "Đã duyệt",
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),

                                  // Vị trí
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        '${listing.district}, ${listing.province}',
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12),

                                  // Dòng dưới cùng: avatar + tên, nút gọi, trái tim
                                  Row(
                                    children: [
                                      // Avatar + Tên
                                      CircleAvatar(
                                        radius: 14,
                                        backgroundColor: Colors.red,
                                        child: Text(
                                          listing.authorName[0].toUpperCase(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        listing.authorName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Spacer(),

                                      // Nút gọi
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.teal,
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.phone,
                                              color: Colors.white,
                                              size: 14,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              controller.maskPhone(
                                                listing.phoneNumber,
                                              ),
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(width: 12),

                                      // Trái tim
                                      Icon(
                                        Icons.favorite_border,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
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
}
