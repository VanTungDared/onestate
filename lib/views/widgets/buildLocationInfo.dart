import 'package:flutter/material.dart';

Widget buildLocationInfo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const [
      SizedBox(height: 24),
      Text("Khu vực", style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      _LocationRow(label: "Tỉnh/Thành phố", value: "Hà Nội"),
      _LocationRow(label: "Quận/Huyện", value: "Thanh Xuân"),
      _LocationRow(label: "Phường/Xã", value: "Hạ Đình"),
      _LocationRow(label: "Số căn", value: "Lô A4/214"),
    ],
  );
}

class _LocationRow extends StatelessWidget {
  final String label;
  final String value;

  const _LocationRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(color: Colors.grey)),
            Text(value, style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }
}
