// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import 'package:flutter/material.dart';

// class CustomNotch extends NotchPainter {
//   @override
//   Path draw(Path path, Rect host, {bool flip = false}) {
//     final double notchHeight = 12; // Độ cao notch
//     final double notchWidth = 60; // Độ rộng notch

//     path.lineTo(host.width / 2 - notchWidth / 2, 0);
//     path.relativeLineTo(notchWidth / 4, -notchHeight);
//     path.relativeLineTo(notchWidth / 2, 0);
//     path.relativeLineTo(notchWidth / 4, notchHeight);
//     path.lineTo(host.width, 0);
//     path.lineTo(host.width, host.height);
//     path.lineTo(0, host.height);
//     path.close();

//     return path;
//   }
// }
