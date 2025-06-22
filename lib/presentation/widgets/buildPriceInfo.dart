import 'package:flutter/material.dart';

Widget buildPriceInfo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Thông tin giá tiền",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      Row(
        children: const [
          Icon(Icons.price_change_outlined, size: 20),
          SizedBox(width: 8),
          Text("Giá chào", style: TextStyle(color: Colors.grey)),
          Spacer(),
          Text(
            "59,500 Triệu VND",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Row(
        children: const [
          Icon(Icons.money_off_csred, size: 20),
          SizedBox(width: 8),
          Text("Trích thưởng", style: TextStyle(color: Colors.grey)),
          Spacer(),
          Text(
            "2% or 300 triệu",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ],
  );
}
