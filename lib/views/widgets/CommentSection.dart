import 'package:app_real_estate/controllers/comment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentSection extends StatelessWidget {
  final commentController = Get.put(CommentController());

  final List<Map<String, dynamic>> comments = [
    {
      "author": "Bích Ngọc Kỳ",
      "title": "Môi giới nhà đất - level 1",
      "content": "Ngôi nhà này thật sự tuyệt đẹp!",
      "replies": [
        {
          "author": "Cảnh Bình Vương",
          "title": "Môi giới nhà đất - level 1",
          "content": "Chắc chắn rồi! Thiết kế của nhà bếp thật long lanh!",
        },
      ],
    },
    {
      "author": "Bích Ngọc Kỳ",
      "title": "Môi giới nhà đất - level 1",
      "content": "Ngôi nhà này thật sự tuyệt đẹp!",
      "replies": [],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(comments.length, (index) {
          return _buildComment(context, comments[index], index);
        }),
      ),
    );
  }

  Widget _buildComment(
    BuildContext context,
    Map<String, dynamic> comment,
    int index, {
    bool isReply = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: isReply ? 32 : 0, top: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User info
          Row(
            children: [
              const CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment['author'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    comment['title'],
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 8),
          Text(comment['content']),
          const SizedBox(height: 8),

          // Action row
          Row(
            children: [
              const Icon(Icons.thumb_up_alt_outlined, size: 18),
              const SizedBox(width: 8),
              const Icon(Icons.thumb_down_alt_outlined, size: 18),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => commentController.toggleReply(index),
                child: const Icon(Icons.reply_outlined, size: 18),
              ),
            ],
          ),

          // Nếu đang trả lời
          if (!isReply && commentController.replyingToIndex.value == index)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (v) => commentController.replyText.value = v,
                      decoration: InputDecoration(
                        hintText: "Nhập câu trả lời...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => commentController.submitReply(index),
                    child: const Text("Gửi"),
                  ),
                ],
              ),
            ),

          // Các câu trả lời (nếu có)
          if (!isReply && comment['replies'] != null)
            ...List.generate(comment['replies'].length, (i) {
              return _buildComment(
                context,
                comment['replies'][i],
                index,
                isReply: true,
              );
            }),
        ],
      ),
    );
  }
}
