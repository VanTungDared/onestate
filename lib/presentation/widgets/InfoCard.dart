import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/constants/api_url.dart';

class InfoCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String listingPriceVndRent;
  final String legalAreaSqm;
  final String province;
  final String district;
  final String own;
  final String updatedAt;
  final VoidCallback onPress;

  const InfoCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.onPress,
    required this.listingPriceVndRent,
    required this.legalAreaSqm,
    required this.province,
    required this.district,
    required this.own,
    required this.updatedAt,
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 2,
              spreadRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 128.w,
              height: 140.h,
              color: Colors.grey,
              child: CachedNetworkImage(
                imageUrl: "${ApiUrl.baseUrlImage}/$imageUrl",
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C2C2C),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  Row(
                    children: [
                      Text(
                        listingPriceVndRent,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Color(0xFFEF4444),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      dot(),
                      SizedBox(width: 6.w),
                      Text(
                        "${legalAreaSqm}m2",
                        style: TextStyle(
                          fontSize: 14.sp,
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
                        "$district, $province",
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              own,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              updatedAt,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Color(0xFF505050),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsGeometry.all(8),
                        child: Icon(
                          Icons.favorite,
                          size: 24.w,
                          color: Colors.red,
                        ),
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
  }

  Widget dot() {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
    );
  }
}
