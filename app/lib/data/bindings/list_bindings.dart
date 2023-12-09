import 'package:get/get.dart';
import 'package:shali_fe/data/controllers/list_controller.dart';
import 'package:shali_fe/data/providers/item_provider.dart';
import 'package:shali_fe/data/repositories/item_repository.dart';

class ListBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ListController(
        itemRepository: Get.put(ItemRepository(Get.put(ItemProvider())))));
  }
}
