
import 'package:flutter/material.dart';

import '../../core/utils/constants/color_constants.dart';
import '../../core/utils/constants/fontstyle_constants.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    this.content,
    this.textStyle,
    this.onclick,
    this.padding,
    this.icon,
  });
  final Widget? icon;
  final TextStyle? textStyle;
  final String? content;
  final Function? onclick;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () => onclick == null ? () {} : onclick!(),
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Row(
            children: [
              icon ?? SizedBox(),
              SizedBox(width: 8),
              Text(
                content ?? "",
                style:
                    textStyle ?? FontstyleConstant.fontS17W600.copyWith(
                          color:
                              onclick != null
                                  ? ColorConstant.primaryColor
                                  : ColorConstant.textColorGray,
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
