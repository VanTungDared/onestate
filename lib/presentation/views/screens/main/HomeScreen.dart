import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../data/models/ListingModel.dart';
import '../../../routers/routerName.dart';
import '../../../widgets/InfoCard.dart';
import 'main_controller.dart';

class HomeScreen extends GetView<MainController> {
  final List<ListingModel>? dataListings; // thêm dòng này
  const HomeScreen({
    super.key,
    required this.dataListings,
  }); // sửa lại constructor

  @override
  Widget build(BuildContext context) {
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
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Row(
                //       children: [
                //         CircleAvatar(
                //           radius: 24,
                //           backgroundImage: NetworkImage(
                //             'https://i.pravatar.cc/150?img=3',
                //           ),
                //         ),
                //         const SizedBox(width: 12),
                //         Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: const [
                //             Text(
                //               'Good Morning',
                //               style: TextStyle(
                //                 fontSize: 12,
                //                 color: Colors.grey,
                //               ),
                //             ),
                //             Text(
                //               'Adrian Hajdin',
                //               style: TextStyle(
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.bold,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ],
                //     ),
                //     Icon(Icons.notifications_none),
                //   ],
                // ),
                // const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouterName.search);
                  },
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
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Có 3 bất động sản',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    _sortWidget(),
                  ],
                ),
                SizedBox(height: 16.h),
                // // List of Info Cards
                // Padding(
                //   padding: const EdgeInsets.all(8),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children:
                //         dataListings!.map((listing) {
                //           return Padding(
                //             padding: const EdgeInsets.only(bottom: 16),
                //             child: InfoCard(
                //               imageUrl: 'https://via.placeholder.com/150',
                //               title: "Ok",
                //               description: listing.description,
                //             ),
                //           );
                //         }).toList(),
                //   ),
                // ),
                InfoCard(
                  imageUrl: 'https://via.placeholder.com/150',
                  title: "ok",
                  description: "ok",
                ),

                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sortWidget() {
    return Container(
      height: 32.h,
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(width: 1.w, color: Colors.grey),
      ),
      child: Row(
        children: [
          Text(
            "Tin mới nhất (Mặc định) ",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
              color: Color(0xFF6B7280),
            ),
          ),
          Icon(Icons.arrow_drop_down, color: Color(0xFF6B7280)),
        ],
      ),
    );
  }
}
