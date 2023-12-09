import 'package:get/get.dart';
import 'package:shali_fe/configs/routes.dart';
import 'package:shali_fe/data/bindings/list_bindings.dart';
import 'package:shali_fe/data/bindings/login_bindings.dart';
import 'package:shali_fe/data/bindings/register_bindings.dart';
import 'package:shali_fe/data/bindings/user_bindings.dart';
import 'package:shali_fe/ui/views/home_view.dart';
import 'package:shali_fe/ui/views/list_view.dart';
import 'package:shali_fe/ui/views/login_view.dart';
import 'package:shali_fe/ui/views/register_view.dart';

class AppPages {
  static final routes = [
    GetPage(
        name: Routes.home,
        page: () => const HomeView(),
        binding: UserBindings()),
    GetPage(
        name: Routes.login,
        page: () => const LoginView(),
        binding: LoginBindings()),
    GetPage(
        name: Routes.register,
        page: () => const RegisterView(),
        binding: RegisterBindings()),
    GetPage(
        name: Routes.list,
        page: () => const MyListView(),
        binding: ListBindings()),
  ];
}
