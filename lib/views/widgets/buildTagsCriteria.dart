import 'package:flutter/material.dart';

Widget buildTagsCriteria() {
  final List<String> tags = [
    "Triệu đô",
    "Lãi vốn (Rẻ)",
    "Dòng tiền ổn định",
    "Chính chủ",
    "Để ở",
    "Để kinh doanh",
    "Hiếm có",
    "Chủ cần bán gấp",
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 24),
      const Text("Tiêu chí", style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      Wrap(
        spacing: 12,
        runSpacing: 8,
        children:
            tags.map((tag) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(value: false, onChanged: (_) {}),
                  Text(tag),
                ],
              );
            }).toList(),
      ),
    ],
  );
}
