import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shali_fe/api_controllers/register_api_controller.dart';
import 'package:shali_fe/models/api_results.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterApiController());
    Get.lazyPut(() => RegisterController());
  }
}

class RegisterController extends GetxController {
  final RegisterApiController apiController = Get.find<RegisterApiController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  final RxBool _isPasswordObscure = true.obs;
  bool get isPasswordObscure => _isPasswordObscure.value;
  set isPasswordObscure(bool value) => _isPasswordObscure.value = value;

  Future<void> register() async {
    if (passwordController.text.trim() !=
        passwordConfirmController.text.trim()) {
      Get.snackbar("Error", "Passwords do not match");
    }
    ApiResults results = await apiController.register(
        nameController.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim());
    if (!results.success) {
      Get.snackbar("Error", results.results);
    } else {
      Get.offAllNamed("/home");
    }
  }
}
