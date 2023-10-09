import 'package:get/get.dart';
import 'package:shali_fe/data/controllers/user_controller.dart';
import 'package:shali_fe/data/providers/list_provider.dart';
import 'package:shali_fe/data/repositories/list_repository.dart';

class UserBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserController(
            listRepository: Get.put(
          ListRepository(listProvider: Get.put(ListProvider())),
        )));
  }
}
