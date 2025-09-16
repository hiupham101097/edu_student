import 'package:flutter/material.dart';

class AppStyle {
  static var colors = [
    [
      //0
      const Color(0xFFD1F4F4), //0
      const Color(0xFF95D4D4), //1
      const Color(0xFF85E1E1), //2
      const Color(0xFF78DCB0), //3
      const Color(0xFF30C8C7), //4
      const Color(0xFF22C9C8), //5
      const Color(0xFF1EC8C8), //6
    ],
    [
      //1
      const Color(0xFFFAFEFE), //0
      const Color(0xFFF8FAFC), //1
      const Color(0xFFF5F6FA), //2
      const Color(0xFFDBEAFE), //3
      const Color(0xFFD4DDE3), //4
      const Color(0xFF9FA4AE), //5
      const Color(0xFF8D9EA4), //6
      const Color(0xFF4B4D5A), //7
      const Color(0xFFe0dcdc), //8
      const Color(0xFFE2E8F0), //9
      const Color(0xFFdbe9e9), //10
      const Color(0xFF21808d), //11
      const Color(0xFF13343b), //12
      const Color(0xFF344054), //13
      const Color(0xFF111928), //14
    ],
    [
      //2
      const Color(0xFF2f4862), //0
      const Color(0xFF15416e), //1
      const Color(0xFF18ba60), //2
      const Color(0xFFe7505a), //3
      const Color(0xFF217EBD), //4
      const Color(0xFFffc439), //5
      const Color(0xFFfff200), //6
      const Color(0xFFff002e), //7
      const Color(0xFF64748B), //8
      const Color(0xFF334155), //9
      const Color(0xFF475569), //10
      const Color(0xFF0f172A), //11
      const Color(0xFF000000), //12
      const Color(0xFFfc581b), //13
      const Color(0xFFFEEBEB), //14
      const Color(0xFF3758F9), //15
    ],
    [
      //3
      const Color(0xFFF0FDF4), //0
      const Color(0xFFBBF7D0), //1
      const Color(0xFF15803D), //2
      const Color(0xFF16A34A), //3
      const Color(0xFF22C55E), //4
      const Color(0xFF00a651), //5  //mau cty
      const Color(0xFF14532D), //6 // mau chữ
      const Color(0xFF00ab4e), //7 // màu logo
      const Color(0xFF2E7D32), //8
      const Color(0xFF1B5E20), //9
      const Color(0xFF10914a), //10
    ],
  ];

  static const borderRadiusCicular = BorderRadius.all(Radius.circular(3.0));
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      // ignore: prefer_interpolation_to_compose_strings
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
