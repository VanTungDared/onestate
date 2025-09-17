import 'package:app_real_estate/data/models/UserModel.dart';
import 'package:app_real_estate/presentation/routers/routerName.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  final UserModel userModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function callLogout;
  const CustomDrawer({
    super.key,
    required this.userModel, // phải có "this." để gán vào field
    required this.scaffoldKey,
    required this.callLogout,
  });
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header user
              Row(
                children: [
                  CircleAvatar(
                    radius: 24.r,
                    backgroundColor: Colors.orange,
                    child: Text(
                      "N",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userModel.fullName,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        userModel.phoneNumber,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => callLogout(),
                    icon: const Icon(Icons.logout, color: Colors.red),
                  ),
                ],
              ),

              SizedBox(height: 12.h),

              // Nút đăng tin
              SizedBox(
                width: double.infinity,
                height: 40.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  onPressed: () {
                    Get.toNamed(RouterName.post);
                  },
                  child: Text(
                    "Đăng tin",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 6.h),
              // Menu items
              _buildMenuItem(
                icon: Icons.article_outlined,
                title: "Bài đăng của tôi",
                onTap: () {
                  scaffoldKey.currentState?.closeEndDrawer();
                  Get.toNamed(RouterName.myArticle);
                },
              ),
              Divider(thickness: 1, height: 1, color: Colors.grey.shade300),
              _buildMenuItem(
                icon: Icons.favorite_border,
                title: "Bài đăng đã thích",
                onTap: () {
                  scaffoldKey.currentState?.closeEndDrawer();
                  Get.toNamed(RouterName.myFavourite);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.black87),
      title: Text(
        title,
        style: TextStyle(fontSize: 15.sp, color: Colors.black87),
      ),
      onTap: onTap,
    );
  }
}
