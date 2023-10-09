import 'package:flutter/material.dart';

class MyThemes {
  static ThemeData lightTheme() {
    return ThemeData.light(useMaterial3: true);
  }

  static ThemeData darkTheme() {
    return ThemeData.dark(useMaterial3: true);
  }
}
