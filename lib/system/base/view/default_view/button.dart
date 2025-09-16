import 'package:flutter/material.dart';
import 'package:edu_student/system/_variables/value/app_style.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? color;
  final double? fontSize;
  const CustomTextButton({
    required this.onPressed,
    required this.text,
    this.fontSize,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: color ?? AppStyle.colors[2][5],
          fontSize: fontSize ?? 14,
          fontFamily: 'Inter',
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final double? height;
  final double? width;
  final double? fontSize;
  final Color? btnColor;
  final Color? fontColor;
  const PrimaryButton({
    super.key,
    required this.onTap,
    required this.text,
    this.height,
    this.width,
    this.fontSize,
    this.btnColor,
    this.fontColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50,
      width: width ?? double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: btnColor ?? AppStyle.colors[2][5],
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: fontColor ?? AppStyle.colors[1][0],
          fontSize: fontSize ?? 24.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Inter',
        ),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  final VoidCallback onTap;
  final Icon? icon;
  const SocialButton({
    super.key,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 59,
        width: 59,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppStyle.colors[1][0],
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 32,
              spreadRadius: 0,
              // ignore: deprecated_member_use
              color: Colors.grey.withOpacity(0.25),
            ),
          ],
        ),
        child: icon,
      ),
    );
  }
}
