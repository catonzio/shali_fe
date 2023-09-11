import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  static get settingsBox => () => GetStorage("settings");

  final RxBool _isDarkMode = false.obs;
  bool get isDarkMode => _isDarkMode.value;
  set isDarkMode(bool value) => _isDarkMode.value = value;

  @override
  void onInit() {
    isDarkMode = settingsBox().read("isDarkMode") ?? Get.isDarkMode ?? false;
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
