import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/profile_controller.dart';
import '../../routers/routerName.dart';

class ProfileScreen extends StatelessWidget {
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Hồ sơ cá nhân'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            /// Avatar + Tên
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(controller.avatarUrl),
            ),
            SizedBox(height: 12),
            Text(
              controller.username,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(controller.bio, style: TextStyle(color: Colors.grey)),
            SizedBox(height: 16),

            /// Thống kê
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStat("Tin đăng", "12"),
                _buildStat("Yêu thích", "230"),
                _buildStat("Theo dõi", "88"),
              ],
            ),
            SizedBox(height: 16),

            /// Nút chỉnh sửa
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.edit, size: 18),
                label: Text("Chỉnh sửa hồ sơ"),
              ),
            ),

            /// Nút đăng xuất
            TextButton.icon(
              onPressed: () {
                // TODO: Viết logic đăng xuất tại đây
                Get.defaultDialog(
                  title: "Đăng xuất",
                  middleText: "Bạn có chắc chắn muốn đăng xuất?",
                  textCancel: "Huỷ",
                  textConfirm: "Đăng xuất",
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    // Xử lý đăng xuất tại đây
                    Get.offAllNamed(
                      RouterName.login,
                    ); // ví dụ chuyển về màn login
                  },
                );
              },
              icon: Icon(Icons.logout, color: Colors.red),
              label: Text("Đăng xuất", style: TextStyle(color: Colors.red)),
            ),

            /// Bài đăng gần đây
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Bài đăng yêu thích",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 12),

            /// Danh sách bài viết
            Column(
              children:
                  controller.posts.map((item) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Ảnh nhà
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                                child: Image.network(
                                  item['image'],
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Obx(
                                  () => GestureDetector(
                                    onTap: () {
                                      item['isFavorite'].value =
                                          !item['isFavorite'].value;
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        item['isFavorite'].value
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Colors.purple,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          /// Nội dung
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['label'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.attach_money,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 4),
                                    Text(item['price']),
                                    Spacer(),
                                    Icon(
                                      Icons.square_foot,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 4),
                                    Text(item['area']),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 4),
        Text(title, style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}
