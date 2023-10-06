import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shali_fe/api_controllers/login_api_controller.dart';
import 'package:shali_fe/api_controllers/api_controller.dart';
import 'package:shali_fe/schemas/login_schema.dart';

class LoginBinding implements Bindings {
// default dependency
  @override
  void dependencies() {
    Get.lazyPut(() => LoginApiController());
    Get.lazyPut(() => LoginController());
  }
}

class LoginController extends ApiController {
  final LoginApiController apiController = Get.find<LoginApiController>();

  final RxBool _isPasswordObscure = false.obs;
  bool get isPasswordObscure => _isPasswordObscure.value;
  set isPasswordObscure(bool value) => _isPasswordObscure.value = value;

  final Rx<LoginSchema> _loginSchema = LoginSchema().obs;
  LoginSchema get loginSchema => _loginSchema.value;
  set loginSchema(LoginSchema value) => _loginSchema.value = value;

  final TextEditingController emailController =
      TextEditingController(text: "dandi@email.com");
  final TextEditingController passwordController =
      TextEditingController(text: "password");

  @override
  void onInit() {
    isPasswordObscure = true;
    super.onInit();
  }

  Future<void> login() async {
    LoginSchema result = await apiController.login(
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
