import 'package:get/get.dart';
import 'package:shali_fe/data/controllers/login_controller.dart';
import 'package:shali_fe/data/providers/user_provider.dart';
import 'package:shali_fe/data/repositories/user_repository.dart';

class LoginBindings implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(
        userRepository:
            Get.put(UserRepository(userProvider: Get.put(UserProvider())))));
  }
}
