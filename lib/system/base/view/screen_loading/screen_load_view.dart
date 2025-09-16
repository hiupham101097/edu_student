// ignore_for_file: use_build_context_synchronously

import 'package:edu_student/system/base/view/intro/intro_view.dart';
import 'package:edu_student/system/base/view/intro2/intro2_view.dart';
import 'package:flutter/material.dart';
import 'package:edu_student/main.dart';
import 'package:edu_student/system/_variables/storage/storage_data.dart';
import 'package:edu_student/system/base/config/config_firebase.dart';
import 'package:edu_student/system/base/config/config_info.dart';
import 'package:edu_student/system/base/config/config_notifi.dart';
import 'package:edu_student/system/base/view/screen_loading/layouts/screen_load_layout.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: use_key_in_widget_constructors
class SplashScreenView extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  double textOpacity = 0.0;
  double logoOpacity = 0.0;
  String? token;

  @override
  void initState() {
    super.initState();
    startApp();
  }

  /// Hàm khởi tạo các cấu hình và điều hướng
  Future<void> startApp() async {
    await Future.wait([initializeFirebase()]);

    // // Nếu đã có token, chuyển luôn không cần đợi animation
    // if (token != null && token!.isNotEmpty) {
    //   // ignore: use_build_context_synchronously
    //   Navigator.pushReplacementNamed(context, '/home');
    //   return;
    // }

    // Hiệu ứng animation
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() => textOpacity = 1.0);
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() => logoOpacity = 1.0);
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() => logoOpacity = 0.0);
    });

    // Chờ hết animation rồi điều hướng
    Future.delayed(const Duration(seconds: 3), () {
      if (token == null) {
        Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      IntroView(),
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
      } else {
        Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      Intro2View(),
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
      }
    });
  }

  // Kết nối Firebase
  Future<void> initializeFirebase() async {
    await StartFirebase.initFirebase();
    await StartFirebase.configFirebase();
    await StartNotification.configNotification();

    remoteMessage = await StartFirebase.getMessage();
    loadUserModel();
    // loadListCity();
  }

  /// Gọi API để lấy thông tin user
  Future<void> loadUserModel() async {
    token = await StorageData.getValue('token');
    if (token != null) {
      await buildUserInfomation(token!);
    }
  }

  /// Gọi API để lấy danh sach thanh pho
  // Future<void> loadListCity() async {
  //   var city = await ProvincesBaseApi().fetchProvinceDetail();

  //   GlobalParams.setCity(city.value!);
  // }

  /// Lấy token từ local storage (nếu có)
  Future<void> loadFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString("auth_token");
    // ignore: avoid_print
    print("✅ Local Storage Token: $token");
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreenLayout(
      textOpacity: textOpacity,
      logoOpacity: logoOpacity,
    );
  }
}
