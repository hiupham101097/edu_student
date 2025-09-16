
import 'package:flutter/material.dart';
import 'package:edu_student/system/_variables/value/app_style.dart';

class SplashScreenLayout extends StatelessWidget {
  final double textOpacity;
  final double logoOpacity;

  // ignore: use_key_in_widget_constructors
  const SplashScreenLayout({
    required this.textOpacity,
    required this.logoOpacity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.colors[1][0],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hiệu ứng hiện chữ
            // AnimatedOpacity(
            //   duration: const Duration(seconds: 1),
            //   opacity: textOpacity,
            //   child: Text(
            //     '',
            //     style: TextStyle(
            //       fontSize: 30,
            //       fontWeight: FontWeight.bold,
            //       color: AppStyle.colors[1][0],
            //       fontFamily: 'Inter',
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 20),

            // Hiệu ứng hiện logo
            AnimatedOpacity(
              duration:const Duration(seconds: 1),
              opacity: logoOpacity,
              child: Image.asset("assets/logo.png", width: 400, height: 400,),
            ),
          ],
        ),
      ),
    );
  }
}
