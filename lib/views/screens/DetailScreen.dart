import 'package:app_real_estate/constants/color_constants.dart';
import 'package:app_real_estate/controllers/detail_controller.dart';
import 'package:app_real_estate/views/widgets/CommentSection.dart';
import 'package:app_real_estate/views/widgets/buildDescriptionTab.dart';
import 'package:app_real_estate/views/widgets/buildInfoRow.dart';
import 'package:app_real_estate/views/widgets/buildLocationInfo.dart';
import 'package:app_real_estate/views/widgets/buildPriceInfo.dart';
import 'package:app_real_estate/views/widgets/buildProjectInformation.dart';
import 'package:app_real_estate/views/widgets/buildTagsCriteria.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailScreen extends StatelessWidget {
  final controller = Get.put(DetailController());
  DetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Kho tổng"),
          centerTitle: true,
          bottom: const TabBar(
            labelColor: ColorConstant.greenColor,
            unselectedLabelColor: Colors.grey,
            indicatorColor: ColorConstant.greenColor,
            tabs: [
              Tab(text: "Thông tin BĐS"),
              Tab(text: "Thông tin dự án"),
              Tab(text: "Mô tả chi tiết"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Obx(
              () =>
                  controller.countRender.value > 0
                      ? buildPropertyInfoTab()
                      : SizedBox(),
            ),
            buildProjectInformation(),
            buildDescriptionTab(),
          ],
        ),
      ),
    );
  }

  Widget buildPropertyInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with dots indicator
          // Image với PageView và indicator
          Container(
            height: 300,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            child: PageView.builder(
              controller: PageController(viewportFraction: 0.9),
              itemCount: controller.listingDetail!.imageUrls.length,
              onPageChanged: (index) {
                controller.changePage(index);
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: controller.apiClient.getFullUrl(
                        controller.listingDetail!.imageUrls.isNotEmpty
                            ? controller.listingDetail!.imageUrls[index]
                            : 'https://via.placeholder.com/150',
                      ),
                      placeholder:
                          (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                      errorWidget:
                          (context, url, error) => const Center(
                            child: Icon(Icons.broken_image, size: 48),
                          ),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 210,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                controller.listingDetail!.imageUrls.length,
                (i) {
                  final isActive = i == controller.currentPage.value;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 8 : 6,
                    height: isActive ? 8 : 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive ? Colors.black : Colors.grey.shade300,
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 16),
          const Text(
            "Dự án TK-98E3FA",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Chip(
                label: const Text("Chuẩn"),
                backgroundColor: Colors.blue.shade50,
                labelStyle: const TextStyle(color: Colors.blue),
              ),
              const SizedBox(width: 12),
              const Text(
                "Mã hàng: ",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const Text(
                "TK-98E3FA",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            "Thông số kỹ thuật",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          buildInfoRow(Icons.square_foot, "Diện tích sổ", "171.3 m2"),
          buildInfoRow(Icons.straighten, "Thực tế", "171.3 m2"),
          buildInfoRow(Icons.height, "Chiều dài", "14.3 m"),
          buildInfoRow(Icons.swap_horiz, "Chiều rộng", "12 m"),
          buildInfoRow(Icons.landscape, "Mặt tiền", "12 m"),
          buildInfoRow(Icons.roundabout_left, "Đường trước nhà", "12 m"),
          buildInfoRow(Icons.home_work, "Số tầng", "4 tầng"),
          const SizedBox(height: 12),
          buildPriceInfo(),
          const SizedBox(height: 16),
          buildTagsCriteria(),
          buildLocationInfo(),
          CommentSection(),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey[700]),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(fontSize: 14)),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: valueColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
