import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomText extends StatelessWidget {
  CustomText({
    super.key,
    this.title,
    this.textColor,
    this.textSize,
    this.textDecoration,
    this.textBold,
    this.textAlign,
    this.maxLines,
  });
  String? title;
  Color? textColor;
  double? textSize;
  TextDecoration? textDecoration;
  FontWeight? textBold;
  TextAlign? textAlign;
  int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(
      title!,
      textAlign:textAlign,
      maxLines: maxLines,
      style: TextStyle(
        color: textColor,
        fontSize: textSize,
        fontFamily: 'Inter',
        decoration: textDecoration,
        fontWeight: textBold,
      ),
    );
  }
}
