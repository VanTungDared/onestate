import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

Widget buildProjectInformation() {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Thông tin nguồn'),
        _buildInfoRow(
          LucideIcons.accessibility,
          'Đối tác',
          'Giá chào >= 25 tỷ',
        ),
        _buildInfoRow(LucideIcons.phone, 'Điện thoại', '0966688094'),

        const SizedBox(height: 24),
        _buildSectionTitle('Thông tin đầu chủ'),
        _buildInfoRow(
          LucideIcons.fileText,
          'Hợp đồng',
          'Đầu chủ Mai Ngọc Trung',
        ),
        _buildInfoRow(LucideIcons.phone, 'Điện thoại', '0966688094'),
        _buildInfoRow(LucideIcons.building2, 'Khối/phòng', 'Kinh Bắc 39'),
        _buildInfoRow(LucideIcons.users, 'Ban lãnh đạo', 'Ban Sao Kim'),
        _buildInfoRow(LucideIcons.phone, 'Đánh giá', '0966688094'),
        _buildInfoRow(
          LucideIcons.facebook,
          'Facebook',
          'Click link',
          valueColor: Colors.blue,
        ),

        const SizedBox(height: 32),
        // SizedBox(
        //   width: double.infinity,
        //   height: 48,
        //   child: ElevatedButton(
        //     style: ElevatedButton.styleFrom(
        //       backgroundColor: const Color(0xFF008080),
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(30),
        //       ),
        //     ),
        //     onPressed: () {
        //       // TODO: Xử lý lưu dự án
        //     },
        //     child: const Text(
        //       'Lưu dự án',
        //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        //     ),
        //   ),
        // ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
  );
}

Widget _buildInfoRow(
  IconData icon,
  String label,
  String value, {
  Color? valueColor,
}) {
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
