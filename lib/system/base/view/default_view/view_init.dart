import 'package:edu_student/system/_variables/value/app_style.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget viewDefault(String? title) {
  return Scaffold(
    backgroundColor: AppStyle.colors[1][0],
    appBar: title != null
        ? AppBar(
            backgroundColor: AppStyle.colors[0][4],
            centerTitle: true,
            title: Text(
              title,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(
                color: AppStyle.colors[1][6], // màu line
                height: 0.5,
              ),
            ),
          )
        : AppBar(),

    body: Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: AppStyle.colors[3][5],
        size: 80,
      ),
    ),
  );
}
