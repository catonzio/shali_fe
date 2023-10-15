import 'package:flutter/material.dart';

class Themes {
  static ThemeData lightTheme() {
    ThemeData light = ThemeData.light(useMaterial3: true);
    return light.copyWith();
  }

  static ThemeData darkTheme() {
    ThemeData dark = ThemeData.dark(useMaterial3: true);
    return dark.copyWith(
        appBarTheme: dark.appBarTheme.copyWith(
            elevation: 1, scrolledUnderElevation: 1, centerTitle: true));
  }

  static ColorScheme colorScheme(BuildContext context) =>
      Theme.of(context).colorScheme;

  static TextTheme textTheme(BuildContext context) =>
      Theme.of(context).textTheme;
}
