import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shali_fe/configs/dimensions.dart';

bool isValidEmail(String email) {
  // Regular expression for a simple email validation
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

  return emailRegex.hasMatch(email);
}

Animate withRotation(BuildContext context, bool condition, Widget parent) {
  double height = Dimensions.height(context);
  double rotationY = height * 0.0001 / 100;

  return parent
      .animate(
        target: condition ? 1 : 0,
        onComplete: (animController) => condition
            ? animController.loop(reverse: true)
            : animController.stop(),
      )
      .rotate(
          begin: condition ? -rotationY : 0, end: rotationY, duration: 100.ms);
}
