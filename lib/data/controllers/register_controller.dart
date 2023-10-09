import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shali_fe/data/models/api_results.dart';
import 'package:shali_fe/data/repositories/user_repository.dart';

class RegisterController extends GetxController {
  final UserRepository userRepository;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  RegisterController({required this.userRepository});

  final RxBool _isPasswordObscure = true.obs;
  bool get isPasswordObscure => _isPasswordObscure.value;
  set isPasswordObscure(bool value) => _isPasswordObscure.value = value;

  Future<void> register() async {
    if (passwordController.text.trim() !=
        passwordConfirmController.text.trim()) {
      Get.snackbar("Error", "Passwords do not match");
    }
    ApiResults results = await userRepository.register(
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
