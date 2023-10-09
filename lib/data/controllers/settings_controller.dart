import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shali_fe/data/models/user.dart';
import 'package:shali_fe/data/repositories/user_repository.dart';

class SettingsController extends GetxController {
  final UserRepository userRepository;

  static get settingsBox => () => GetStorage("settings");

  final RxBool _isDarkMode = false.obs;
  bool get isDarkMode => _isDarkMode.value;
  set isDarkMode(bool value) => _isDarkMode.value = value;

  User user = User.initial();

  SettingsController({required this.userRepository});

  @override
  Future<void> onInit() async {
    isDarkMode = settingsBox().read("isDarkMode") ?? Get.isDarkMode ?? false;
    user = User.fromJson(await userRepository.fetchUser());
    super.onInit();
  }

  @override
  void onReady() {
    Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
    super.onReady();
  }

  void toggleDarkMode(bool value) {
    isDarkMode = value;
    settingsBox().write("isDarkMode", isDarkMode);
    Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }
}
