import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Intro2Layout extends StatelessWidget {
  final double textOpacity;
  String? socialName;

  // ignore: use_key_in_widget_constructors
  Intro2Layout({
    required this.textOpacity,
    this.socialName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hiệu ứng hiện chữ
            AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: textOpacity,
              child: Text(
                'Mừng $socialName đã trở lại',
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: textOpacity,
              child: const Text(
                'Chúng tôi sẽ hỗ trợ ban',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
