import 'package:flutter/material.dart';
import 'package:task/src/core/ui/color_outlet.dart';

class CommonText extends StatelessWidget {
  final String text;
  final Color? fontColor;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final double? fontSize;

  const CommonText(
      {Key? key,
      required this.text,
      this.fontColor,
      this.fontWeight,
      this.fontStyle,
      this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: fontColor ?? ColorOutlet.textColorDefault,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        fontSize: fontSize,
      ),
    );
  }
}
