import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shali_fe/api_controllers/api_controller.dart';
import 'package:shali_fe/controllers/home_controller.dart';
import 'package:shali_fe/controllers/list_controller.dart';
import 'package:shali_fe/controllers/login_controller.dart';
import 'package:shali_fe/controllers/register_controller.dart';
import 'package:shali_fe/controllers/settings_controller.dart';
import 'package:shali_fe/firebase_options.dart';
import 'package:shali_fe/notifications.dart';
import 'package:shali_fe/views/home_view.dart';
import 'package:shali_fe/views/list_view.dart';
import 'package:shali_fe/views/login_view.dart';
import 'package:shali_fe/views/register_view.dart';

import 'notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseOptions? options = DefaultFirebaseOptions.currentPlatform;
  if (options != null) {
    await Firebase.initializeApp(options: options);
    await NotificationService.initializePlatformNotifications();
    handleDeviceToken();
    handleNotifications();
  }
  await GetStorage.init("api");
  await GetStorage.init("settings");
  runApp(const MyApp());
}

class InitialBinding implements Bindings {
// default dependency
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController());
    Get.lazyPut(() => HomeController());
    // Get.put(ApiController());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ApiController());
    Get.put(SettingsController());
    return GetMaterialApp(
      title: 'ShaLi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.system,
      initialBinding: InitialBinding(),
      initialRoute:
          Get.find<ApiController>().apiToken == null ? "/login" : "/home",
      getPages: [
        GetPage(
            name: "/login",
            page: () => const LoginView(),
            binding: LoginBinding()),
        GetPage(name: "/home", page: () => HomeView(), binding: HomeBinding()),
        GetPage(
            name: "/list", page: () => MyListView(), binding: ListBinding()),
        GetPage(
            name: "/register",
            page: () => const RegisterView(),
            binding: RegisterBinding())
      ],
    );
  }
}
