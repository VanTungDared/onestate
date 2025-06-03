import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {
  final double? horizontalPadding;
  final double? verticalPadding;
  final String content;
  final VoidCallback? callBack;
  final double? radius;
  final Color? color;
  final Widget? icon;
  final TextStyle? textStyle;
  final BoxBorder? boxBorder;

  const ButtonPrimary({
    super.key,
    this.horizontalPadding,
    this.verticalPadding,
    required this.content,
    this.callBack,
    this.radius,
    this.color,
    this.icon,
    this.textStyle,
    this.boxBorder,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callBack,
      child: Container(
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(radius ?? 12),
          border: boxBorder,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 8,
          vertical: verticalPadding ?? 12,
        ),
        child: Row(
          children: [
            icon ?? SizedBox(),
            Text(
              content,
              style: textStyle ?? TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
