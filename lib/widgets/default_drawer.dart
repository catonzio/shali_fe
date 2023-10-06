import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shali_fe/api_controllers/home_api_controller.dart';
import 'package:shali_fe/controllers/settings_controller.dart';

class DefaultDrawer extends StatelessWidget {
  const DefaultDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<SettingsController>(
      builder: (controller) {
        return Drawer(
            child: Column(
          children: [
            DrawerHeader(
              child: Center(
                  child: Text("ShaLi", style: Get.textTheme.headlineLarge)),
            ),
            ListTile(
                title: const Text("Dark Mode"),
                onTap: () => Get.toNamed("/home"),
                trailing: Switch(
                    value: controller.isDarkMode,
                    onChanged: (value) => controller.toggleDarkMode(value))),
            const Spacer(),
            ListTile(
              title: const Text("Settings"),
              onTap: () => Get.toNamed("/settings"),
            ),
            ListTile(
              title: const Text("Logout"),
              onTap: () => Get.find<HomeApiController>().logout(),
            )
          ],
        ));
      },
    );
  }
}
