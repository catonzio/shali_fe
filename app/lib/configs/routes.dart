import 'package:get/get.dart';
import 'package:shali_fe/data/providers/client_provider.dart';

abstract class Routes {
  static String initial = Get.put(ClientProvider().init()).apiToken == null
      ? Routes.login
      : Routes.home;
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String list = '/list';
  static const String settings = '/settings';
}
