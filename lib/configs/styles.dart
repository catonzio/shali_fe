import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

TextStyle checkedStyle = TextStyle(
    color: Get.theme.colorScheme.onSurface.withOpacity(0.3),
    decoration: TextDecoration.lineThrough,
    fontStyle: FontStyle.italic,
    decorationThickness: 1.5,
    decorationColor: Get.theme.colorScheme.onSurface);
