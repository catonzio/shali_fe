import 'package:get/get.dart';
import 'package:shali_fe/data/controllers/register_controller.dart';
import 'package:shali_fe/data/providers/user_provider.dart';
import 'package:shali_fe/data/repositories/user_repository.dart';

class RegisterBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController(
        userRepository:
            Get.put(UserRepository(userProvider: Get.put(UserProvider())))));
  }
}
