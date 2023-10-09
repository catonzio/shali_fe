import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shali_fe/configs/routes.dart';
import 'package:shali_fe/data/controllers/settings_controller.dart';
import 'package:shali_fe/data/repositories/user_repository.dart';

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
                onTap: () => Get.toNamed(Routes.home),
                trailing: Switch(
                    value: controller.isDarkMode,
                    onChanged: (value) => controller.toggleDarkMode(value))),
            const Spacer(),
            ListTile(
              title: const Text("Settings"),
              onTap: () => Get.toNamed(Routes.settings),
            ),
            ListTile(
              title: const Text("Logout"),
              onTap: () => Get.find<UserRepository>().logout(),
            )
          ],
        ));
      },
    );
  }
}
