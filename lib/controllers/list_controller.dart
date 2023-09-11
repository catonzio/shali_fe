import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shali_fe/controllers/api_controller.dart';
import 'package:shali_fe/models/item.dart';
import 'package:shali_fe/models/list.dart';

class ListBinding implements Bindings {
// default dependency
  @override
  void dependencies() {
    Get.lazyPut(() => ListController());
  }
}

class ListController extends GetxController {
  late Rx<ListModel> _list;
  ListModel get list => _list.value;
  set list(ListModel value) => _list.value = value;

  final RxBool _isMoving = false.obs;
  bool get isMoving => _isMoving.value;
  set isMoving(bool value) => _isMoving.value = value;

  final RxBool _isLoadingItems = false.obs;
  bool get isLoadingItems => _isLoadingItems.value;
  set isLoadingItems(bool value) => _isLoadingItems.value = value;

  @override
  Future<void> onInit() async {
    ApiController apiController = Get.find<ApiController>();
    _list = (Get.arguments as ListModel).obs;
    if (list.items.isEmpty) {
      isLoadingItems = true;
      List<ItemModel> items = await apiController.fetchListItems(list.id);
      list.items.addAll(items);
      isLoadingItems = false;
    }
    super.onInit();
  }

  Future<void> addItem(String title, String description) async {
    if (title.isEmpty) {
      Get.snackbar(
          "Title is empty", "When you add an item you must specify a title");
    } else {
      ApiController apiController = Get.find<ApiController>();
      ItemModel item = ItemModel(
          key: UniqueKey(),
          id: list.items.length + 1,
          name: title,
          description: description);
      bool success = await apiController.addItem(list.id, item);
      if (success) {
        list.items.add(item);
      } else {
        Get.snackbar("Add item failed", "Please try again later");
      }
    }
  }

  reorderItems(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final ItemModel item = list.items.removeAt(oldIndex);
    list.items.insert(newIndex, item);
  }

  void removeItem(int index) async {
    ApiController apiController = Get.find<ApiController>();
    ItemModel item = list.items[index];
    bool success = await apiController.removeItem(item.id);
    if (success) {
      list.items.removeAt(index);
    } else {
      Get.snackbar("Remove item failed", "Please try again later");
    }
  }

  void updateItem(int id, Map<String, dynamic> params) {
    ApiController apiController = Get.find<ApiController>();
    apiController.updateItem(id, params);
  }
}
