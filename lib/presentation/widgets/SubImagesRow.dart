import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SubImagesRow extends StatelessWidget {
  final List<String> imageUrls;
  final dynamic
  controller; // hoặc bạn thay kiểu cho chuẩn hơn nếu biết controller chính xác

  const SubImagesRow({
    Key? key,
    required this.imageUrls,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int displayCount = min(3, imageUrls.length);
    bool hasMore = imageUrls.length > 3;

    return Row(
      children: List.generate(displayCount, (index) {
        final imageUrl = controller.apiClient.getFullUrl(imageUrls[index]);
        final isFirst = index == 0;
        final isLast = index == displayCount - 1;

        return Expanded(
          child: Container(
            margin: EdgeInsets.only(left: index == 0 ? 0 : 6),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft:
                        isFirst ? const Radius.circular(16) : Radius.zero,
                    bottomRight:
                        isLast ? const Radius.circular(16) : Radius.zero,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    placeholder:
                        (context, url) =>
                            Center(child: const CircularProgressIndicator()),
                    errorWidget:
                        (context, url, error) => const Icon(Icons.error),
                    fit: BoxFit.fill,
                    height: 80,
                  ),
                ),
                if (isLast && hasMore)
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.only(
                        bottomRight: const Radius.circular(16),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '+${imageUrls.length - 3}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
