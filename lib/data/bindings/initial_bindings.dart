import 'package:get/get.dart';
import 'package:shali_fe/data/controllers/settings_controller.dart';
import 'package:shali_fe/data/providers/client_provider.dart';
import 'package:shali_fe/data/providers/user_provider.dart';
import 'package:shali_fe/data/repositories/user_repository.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => HomeController());
    // await GetStorage.init("api");
    // await GetStorage.init("settings");
    // Get.putAsync(() => ApiController().onInit());
    // Get.put(ApiController());
    Get.put(ClientProvider().init(), permanent: true);
    Get.put(
        SettingsController(
          userRepository: Get.put(
            UserRepository(userProvider: Get.put(UserProvider())),
          ),
        ),
        permanent: true);
  }
}
