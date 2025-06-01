import 'package:app_real_estate/controllers/detail_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailScreen extends StatelessWidget {
  final controller = Get.put(DetailController());

  DetailScreen({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        centerTitle: true,
        // actions: [IconButton(icon: const Icon(Icons.menu), onPressed: () {})],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.countRender.value == 0) {
          return const Center(child: CircularProgressIndicator());
        }

        final images = controller.listingDetail?.imageUrls ?? [];

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image slider with navigation
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 220,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: images.isNotEmpty ? images.length : 3,
                      itemBuilder: (context, index) {
                        if (images.isNotEmpty) {
                          final imageUrl =
                              controller.apiClient.getFullUrl(images[index]);

                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Center(
                                child: Icon(Icons.broken_image,
                                    color: Colors.grey, size: 40),
                              ),
                            ),
                          );
                        } else {
                          // Placeholder khi không có ảnh
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.grey[(index + 1) * 200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.image,
                                size: 60,
                                color: Colors.white,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),

                  // Left arrow
                  Positioned(
                    left: 8,
                    child: _imageNavButton(Icons.arrow_back, () {
                      if (_pageController.hasClients) {
                        final page = _pageController.page?.toInt() ?? 0;
                        _pageController.animateToPage(
                          page > 0 ? page - 1 : 0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    }),
                  ),
                  // Right arrow
                  Positioned(
                    right: 8,
                    child: _imageNavButton(Icons.arrow_forward, () {
                      if (_pageController.hasClients) {
                        final page = _pageController.page?.toInt() ?? 0;
                        final maxPage =
                            (images.isNotEmpty ? images.length : 3) - 1;
                        _pageController.animateToPage(
                          page < maxPage ? page + 1 : maxPage,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    }),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  controller.listingDetail!.title ?? "",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Info: Giá - Diện tích - Số tầng - Trạng thái
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _infoItem(
                      "Mức giá",
                      _formatCurrency(
                        controller.listingDetail!.listingPriceVnd ?? "",
                      ),
                    ),
                    _infoItem(
                      "Diện tích",
                      "${controller.listingDetail!.actualAreaSqm ?? 'N/A'} m²",
                    ),
                    _infoItem(
                      "Số tầng",
                      "${controller.listingDetail!.numberOfFloors ?? 'N/A'}",
                    ),
                    _statusTag(controller.listingDetail!.status ?? ""),
                  ],
                ),
              ),

              const Divider(height: 32),

              // Thông tin mô tả
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Thông tin mô tả",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  controller.listingDetail!.description ?? "Chưa có mô tả",
                ),
              ),

              const SizedBox(height: 16),

              // Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _actionButton(Icons.share, "Chia sẻ"),
                    const SizedBox(width: 12),
                    _actionButton(Icons.report, "Báo xấu"),
                    const SizedBox(width: 12),
                    Obx(
                      () => _actionButton(
                          controller.isLiked.value
                              ? Icons.favorite
                              : Icons.favorite_border,
                          "",
                          callBack: () => controller.handleLikeListing(),
                          color: controller.isLiked.value ? Colors.red : null),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Thông số kỹ thuật
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Thông số kỹ thuật",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    _techInfoRow(
                      "Diện tích sổ",
                      "${controller.listingDetail!.legalAreaSqm ?? '-'} m²",
                    ),
                    _techInfoRow(
                      "Thực tế",
                      "${controller.listingDetail!.actualAreaSqm ?? '-'} m²",
                    ),
                    _techInfoRow(
                      "Chiều dài",
                      "${controller.listingDetail!.frontageMeters ?? '-'} m",
                    ),
                    _techInfoRow(
                      "Chiều rộng",
                      "${controller.listingDetail!.widthMeters ?? '-'} m",
                    ),
                    _techInfoRow("Mặt tiền", "-"),
                    _techInfoRow(
                      "Đường trước nhà",
                      "${controller.listingDetail!.roadWidthMeters ?? '-'} m",
                    ),
                    _techInfoRow(
                      "Số tầng",
                      "${controller.listingDetail!.numberOfFloors} tầng",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Tiêu chí
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Tiêu chí",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    _criterionChip("Lãi vốn (Rẻ)"),
                    const SizedBox(width: 8),
                    _criterionChip("Thang máy"),
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    _techInfoRow(
                      "Giá chào",
                      _formatCurrency(
                        controller.listingDetail!.listingPriceVnd ?? "",
                      ),
                    ),
                    _techInfoRow(
                      "Trích thưởng",
                      "${controller.listingDetail!.commissionRatePercent}% hoặc ${_formatCurrency(controller.listingDetail!.commissionAmountVnd)}",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Thông tin người đăng
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Thông tin người đăng",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.red,
                          child: Text(
                            "L",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Người đăng", style: TextStyle(fontSize: 13)),
                            Text(
                              controller.listingDetail!.authorName ?? "",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.phone, size: 20),
                        SizedBox(width: 8),
                        Text(
                          controller.listingDetail!.phoneNumber ?? "",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Thông tin chủ nhà
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Thông tin chủ nhà",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.pink,
                          child: Text(
                            "V",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Chủ nhà", style: TextStyle(fontSize: 13)),
                            Text(
                              controller.listingDetail!.ownerName ?? "",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Khu vực
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Khu vực",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _locationItem("Tỉnh/Thành phố",
                        controller.listingDetail!.province!.name),
                    _locationItem(
                        "Quận/Huyện", controller.listingDetail!.district!.name),
                    _locationItem(
                        "Phường/Xã", controller.listingDetail!.ward!.name),
                    _locationItem(
                        "Địa chỉ", controller.listingDetail!.fullAddress ?? ""),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                height: 300,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        double.tryParse(
                                controller.listingDetail!.latitude ?? "0") ??
                            0,
                        double.tryParse(
                                controller.listingDetail!.longitude ?? "0") ??
                            0),
                    zoom: 14.0,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId('vị trí'),
                      position: LatLng(
                          double.tryParse(
                                  controller.listingDetail!.latitude ?? "0") ??
                              0,
                          double.tryParse(
                                  controller.listingDetail!.longitude ?? "0") ??
                              0),
                      infoWindow: InfoWindow(title: 'Địa điểm bạn chọn'),
                    )
                  },
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _infoItem(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _statusTag(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: status == "approved" ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status == "approved" ? "Đã duyệt" : "Chờ duyệt",
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  Widget _actionButton(IconData icon, String label,
      {VoidCallback? callBack, Color? color}) {
    return GestureDetector(
      onTap: callBack ?? () {}, // nếu null thì dùng hàm rỗng
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color ?? Colors.black, size: 18),
            if (label.isNotEmpty) ...[
              const SizedBox(width: 6),
              Text(label, style: const TextStyle(fontSize: 13)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _imageNavButton(IconData icon, VoidCallback onPressed) {
    return CircleAvatar(
      // ignore: deprecated_member_use
      backgroundColor: Colors.white.withOpacity(0.9),
      child: IconButton(
        icon: Icon(icon, color: Colors.black),
        onPressed: onPressed,
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

  Widget _techInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: Colors.black54),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey)),
          ),
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
