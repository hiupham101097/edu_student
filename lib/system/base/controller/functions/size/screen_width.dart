import 'package:flutter/material.dart';

class ScreenWidth {
  static double setScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static setScreen(double screenWidth) {
    if (screenWidth < 150.0) {
      return 150.0;
    } else if (screenWidth < 150.0 && screenWidth < 350.0) {
      return 180.0;
    } else if (screenWidth > 350.0 && screenWidth < 500.0) {
      return 280.0;
    } else if (screenWidth > 500.0 && screenWidth < 1000.0) {
      return 600.0;
    } else if (screenWidth > 1000.0 && screenWidth < 1500.0) {
      return 700.0;
    } else {
      return 150.0;
    }
  }
}
