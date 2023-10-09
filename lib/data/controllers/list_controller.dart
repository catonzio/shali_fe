import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shali_fe/data/models/item.dart';
import 'package:shali_fe/data/models/list.dart';
import 'package:shali_fe/data/repositories/item_repository.dart';

class ListController extends GetxController {
  final ItemRepository itemRepository;

  late Rx<ListModel> _list;
  ListModel get list => _list.value;
  set list(ListModel value) => _list.value = value;

  final RxBool _isMoving = false.obs;
  bool get isMoving => _isMoving.value;
  set isMoving(bool value) => _isMoving.value = value;

  final RxBool _isLoadingItems = false.obs;
  bool get isLoadingItems => _isLoadingItems.value;
  set isLoadingItems(bool value) => _isLoadingItems.value = value;

  ListController({required this.itemRepository});

  @override
  Future<void> onInit() async {
    _list = (Get.arguments as ListModel).obs;
    if (list.items.isEmpty) {
      isLoadingItems = true;
      List<ItemModel> items = await itemRepository.fetchListItems(list.id);
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
      ItemModel item = ItemModel(
          key: UniqueKey(),
          id: list.items.length + 1,
          name: title,
          description: description);
      bool success = await itemRepository.addItem(list.id, item);
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
    ItemModel item = list.items[index];
    bool success = await itemRepository.removeItem(item.id);
    if (success) {
      list.items.removeAt(index);
    } else {
      Get.snackbar("Remove item failed", "Please try again later");
    }
  }

  void updateItem(int id, Map<String, dynamic> params) {
    itemRepository.updateItem(id, params);
  }
}
