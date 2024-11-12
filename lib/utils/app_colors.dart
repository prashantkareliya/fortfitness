import 'package:flutter/material.dart';

class AppColors {
  static Color blackColor = const Color(0xFF0E0F0C);
  static Color whiteColor = const Color(0xFFFFFFFF);
  static Color primaryColor = const Color(0xFFF97316);
  static Color errorRed = const Color(0xFFFF0000);
  static Color greenDone = const Color(0xFF88C941);
  static Color gray = const Color(0xFF989898);
  static Color grayTile = const Color(0xFFF3F3F4);



  static int _hash(String value) {
    int hash = 0;
    for (var code in value.runes) {
      hash = code + ((hash << 2) - hash);
    }
    return hash;
  }

  static Color stringToColor(String value) {
    return Color(stringToHexInt(value));
  }

  static String stringToHexColor(String value) {
    String c = (_hash(value) & 0x00FFFFFF).toRadixString(16).toUpperCase();
    return "0xFF000000".substring(0, 10 - c.length) + c;
  }

  static int stringToHexInt(String value) {
    String c = (_hash(value) & 0x00FFFFFF).toRadixString(16).toUpperCase();
    String hex = "FF000000".substring(0, 8 - c.length) + c;
    return int.parse(hex, radix: 16);
  }
}
