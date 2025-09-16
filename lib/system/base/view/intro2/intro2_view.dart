import 'package:edu_student/system/_variables/storage/fcm_storage_data.dart';
import 'package:edu_student/system/_variables/storage/global_params.dart';
import 'package:edu_student/system/_variables/storage/storage_data.dart';
import 'package:edu_student/system/base/view/intro2/layouts/intro2_layout.dart';
import 'package:flutter/material.dart';
import 'dart:async';

// ignore: use_key_in_widget_constructors, must_be_immutable
class Intro2View extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _Intro2ViewState createState() => _Intro2ViewState();
}

class _Intro2ViewState extends State<Intro2View> {
  double textOpacity = 0.0;
  String? socalName;

  @override
  void initState() {
    super.initState();
    startApp();
  }

  /// Hàm khởi tạo các cấu hình và điều hướng
  Future<void> startApp() async {
    var name = await FCMStorageData.getSocalName();
    socalName = name;

    // Hiệu ứng animation
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() => textOpacity = 1.0);
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() => textOpacity = 0.0);
    });

    // Chờ hết animation rồi điều hướng
    Future.delayed(const Duration(seconds: 5), () async {
      var token = await StorageData.getValue('token');
      if (token != null) {
        GlobalParams.setAuthToken(token);
        // ignore: use_build_context_synchronously
        
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Intro2Layout(
      textOpacity: textOpacity,
      socialName: socalName ?? "",
    );
  }
}
