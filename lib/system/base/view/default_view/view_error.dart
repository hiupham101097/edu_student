import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:edu_student/system/_variables/value/app_style.dart';
import 'package:flutter/material.dart';
import 'package:edu_student/view/home/home_view.dart';

Widget viewError(BuildContext context) {
  return Scaffold(
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(child: Image.asset('assets/dribbble.gif', height: 300.0)),

        AnimatedTextKit(
          animatedTexts: [
            TyperAnimatedText(
              'Hệ thống đang bảo trì ...',
              textStyle: TextStyle(
                fontSize: 20.0,
                color: AppStyle.colors[3][5],
                fontFamily: 'Inter',
              ),
              speed: Duration(milliseconds: 80),
            ),
          ],
          totalRepeatCount: 200,
          pause: Duration(milliseconds: 500),
          displayFullTextOnTap: true,
          stopPauseOnTap: false,
        ),

        SizedBox(height: 20.0),

        TextButton(
          onPressed: () {
            Navigator.push(
              // ignore: use_build_context_synchronously
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    HomeView(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0); // 👈 Trái ➝ phải
                      const end = Offset.zero;
                      final tween = Tween(
                        begin: begin,
                        end: end,
                      ).chain(CurveTween(curve: Curves.easeInOut));
                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppStyle.colors[3][5],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
              child: Text(
                'Quay lại trang chủ',
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  color: AppStyle.colors[1][0],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
