import 'package:app_real_estate/controllers/category_controller.dart';
import 'package:app_real_estate/models/ListingModel.dart';
import 'package:app_real_estate/routers/routerName.dart';
import 'package:app_real_estate/views/widgets/SubImagesRow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  final List<ListingModel>? dataListings; // thêm dòng này
  const CategoryScreen({
    super.key,
    required this.dataListings,
  }); // sửa lại constructor
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Bí kíp",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?img=3',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              /// Search Box
              GestureDetector(
                onTap: () {
                  Get.toNamed(
                    RouterName.search,
                  ); // Sử dụng GetX để chuyển trang
                },
                child: Container(
                  height: 46, // 👈 Fix quan trọng
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Tìm kiếm bằng từ khóa',
                          style: TextStyle(color: Colors.grey),
                          overflow:
                              TextOverflow.ellipsis, // để tránh lỗi text dài
                        ),
                      ),
                      Icon(Icons.tune, color: Colors.grey),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              /// Danh sách
              Expanded(
                child: ListView.builder(
                  itemCount: dataListings?.length ?? 0,
                  itemBuilder: (context, index) {
                    final listing = dataListings![index]; // lấy ListingModel
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
                                    imageUrl: controller.apiClient.getFullUrl(
                                      (listing.imageUrls.isNotEmpty)
                                          ? listing.imageUrls.first
                                          : 'https://via.placeholder.com/150',
                                    ),
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
                                  Text(
                                    listing.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 4),
                                      Text(listing.ownerName),
                                      Spacer(),
                                      Icon(
                                        Icons.attach_money,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        _formatPrice(listing.listingPriceVnd),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 4),
                                      Text(listing.authorName),
                                      Spacer(),
                                      Icon(
                                        Icons.square_foot,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 4),
                                      Text('${listing.legalAreaSqm} m²'),
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
