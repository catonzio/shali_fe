import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shali_fe/configs/themes.dart';

TextStyle checkedStyle(BuildContext context) {
  final colors = Themes.colorScheme(context);
  return TextStyle(
      color: colors.onSurface.withOpacity(0.6),
      decoration: TextDecoration.lineThrough,
      fontStyle: FontStyle.italic,
      decorationThickness: 1.5,
      decorationColor: colors.onSurface);
}
