import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shali_fe/configs/notifications/firebase_options.dart';
import 'package:shali_fe/configs/notifications/notification_service.dart';
import 'package:shali_fe/configs/notifications/notifications.dart';
import 'package:shali_fe/configs/pages.dart';
import 'package:shali_fe/configs/routes.dart';
import 'package:shali_fe/configs/themes.dart';
import 'package:shali_fe/data/bindings/initial_bindings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeApp();
  runApp(const MyApp());
}

Future<void> initializeApp() async {
  FirebaseOptions? options = DefaultFirebaseOptions.currentPlatform;
  await GetStorage.init("api");
  await GetStorage.init("settings");
  if (options != null) {
    await Firebase.initializeApp(options: options);
    await NotificationService.initializePlatformNotifications();
    bool res = await requestNotificationPermissions();
    if (res) {
      handleDeviceToken();
      handleNotifications();
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(ClientProvider(), permanent: true);
    return GetMaterialApp(
        title: 'ShaLi',
        debugShowCheckedModeBanner: false,
        theme: Themes.lightTheme(),
        darkTheme: Themes.darkTheme(),
        themeMode: ThemeMode.system,
        initialBinding: InitialBinding(),
        initialRoute: Routes.initial,
        // Get.find<ApiController>().apiToken == null ? Routes.login : Routes.home,
        defaultTransition: Transition.fade,
        getPages: AppPages.routes);
  }
}
