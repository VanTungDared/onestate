import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/ListingModel.dart';
import '../../controllers/home_controller.dart';
import '../../routers/routerName.dart';
import '../../widgets/InfoCard.dart';

class HomeScreen extends StatelessWidget {
  final List<ListingModel>? dataListings; // thêm dòng này
  const HomeScreen({
    super.key,
    required this.dataListings,
  }); // sửa lại constructor

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // AppBar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(
                            'https://i.pravatar.cc/150?img=3',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Good Morning',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              'Adrian Hajdin',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Icon(Icons.notifications_none),
                  ],
                ),
                const SizedBox(height: 20),

                // Search bar
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

                const SizedBox(height: 20),

                // Title
                const Text(
                  'Thông tin nội bộ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                // List of Info Cards
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        dataListings!.map((listing) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: InfoCard(
                              // imageUrl: controller.apiClient.getFullUrl(
                              //   (listing.imageUrls.isNotEmpty)
                              //       ? listing.imageUrls.first
                              //       : 'https://via.placeholder.com/150',
                              // ),
                              imageUrl: 'https://via.placeholder.com/150',
                              title: listing.title,
                              description: listing.description,
                            ),
                          );
                        }).toList(),
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
}
