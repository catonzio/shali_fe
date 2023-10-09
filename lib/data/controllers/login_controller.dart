import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shali_fe/data/repositories/user_repository.dart';
import 'package:shali_fe/data/schemas/login_schema.dart';

class LoginController extends GetxController {
  final UserRepository userRepository;

  final RxBool _isPasswordObscure = false.obs;
  bool get isPasswordObscure => _isPasswordObscure.value;
  set isPasswordObscure(bool value) => _isPasswordObscure.value = value;

  final Rx<LoginSchema> _loginSchema = LoginSchema().obs;
  LoginSchema get loginSchema => _loginSchema.value;
  set loginSchema(LoginSchema value) => _loginSchema.value = value;

  final TextEditingController emailController =
      TextEditingController(text: "string@email.com");
  final TextEditingController passwordController =
      TextEditingController(text: "string");

  LoginController({required this.userRepository});

  @override
  Future<void> onInit() async {
    isPasswordObscure = true;
    super.onInit();
  }

  Future<void> login() async {
    LoginSchema result = await userRepository.login(
        emailController.text.trim(), passwordController.text.trim());
    if (result.success) {
      Get.offAllNamed("/home");
    } else if (result.fieldMissing) {
      Get.snackbar("Login failed", "Field is missing");
    } else {
      Get.snackbar("Login failed", "Incorrect email or password");
    }
  }
}
