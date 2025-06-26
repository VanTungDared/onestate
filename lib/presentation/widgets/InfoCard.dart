import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final VoidCallback onPress;

  const InfoCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 140.h,
        width: 400.w,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Row(
          children: [
            Container(width: 128.w, height: 140.h, color: Colors.grey),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Quỹ căn stu, 1 - 3PN Vin OCP chính chủ view đẹp giá rẻ, pháp lý rõ ràng miễn phí MG, HT vay 80%",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C2C2C),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  Row(
                    children: [
                      Text(
                        "10 triệu",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Color(0xFFEF4444),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      dot(),
                      SizedBox(width: 12.w),
                      Text(
                        "70m2",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Color(0xFFEF4444),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Color(0xFF505050),
                        size: 16.w,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "Cầu giấy, Hà Nội",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Color(0xFF505050),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hà Nội",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "7 ngày trước",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Color(0xFF505050),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(Icons.favorite, size: 24.w, color: Colors.red),
                      SizedBox(width: 8.w),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dot() {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
    );
  }
}

// CachedNetworkImage(
//   imageUrl: imageUrl,
//   placeholder: (context, url) => const CircularProgressIndicator(),
//   errorWidget: (context, url, error) => const Icon(Icons.error),
//   fit: BoxFit.cover,
// ),
