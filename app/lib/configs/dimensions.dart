import 'package:flutter/material.dart';

class Dimensions {
  static height(BuildContext context, {double? perc}) =>
      MediaQuery.of(context).size.height * (perc ?? 100) / 100;

  static width(BuildContext context, {double? perc}) =>
      MediaQuery.of(context).size.width * (perc ?? 100) / 100;
}
