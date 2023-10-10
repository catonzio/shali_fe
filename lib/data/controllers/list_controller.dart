import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shali_fe/data/controllers/list_elements_controller.dart';
import 'package:shali_fe/data/models/item.dart';
import 'package:shali_fe/data/models/list.dart';
import 'package:shali_fe/data/repositories/item_repository.dart';

class ListController extends ListElementsController {
  final ItemRepository itemRepository;

  late Rx<ListModel> _list;
  ListModel get list => _list.value;
  set list(ListModel value) => _list.value = value;

  final RxBool _isLoadingItems = false.obs;
  bool get isLoadingItems => _isLoadingItems.value;
  set isLoadingItems(bool value) => _isLoadingItems.value = value;

  final RxList<ItemModel> _visibleItems = <ItemModel>[].obs;
  List<ItemModel> get visibleItems => _visibleItems;
  set visibleItems(List<ItemModel> value) => _visibleItems.value = value;

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
    if (visibleItems.isEmpty) {
      visibleItems = list.items;
    }
    super.onInit();
  }

  @override
  Future<bool> addElements() async {
    if (nameController.text.isEmpty) {
      Get.snackbar(
          "Title is empty", "When you add an item you must specify a title");
      return false;
    } else {
      ItemModel item = ItemModel(
          key: UniqueKey(),
          id: list.items.length + 1,
          name: nameController.text.trim(),
          description: descriptionController.text.trim());
      bool success = await itemRepository.addItem(list.id, item);
      if (success) {
        list.items.add(item);
        filter(searchController.text.trim());
        nameController.clear();
        descriptionController.clear();
      } else {
        Get.snackbar("Add item failed", "Please try again later");
      }
      return success;
    }
  }

  @override
  void removeElements(int index) async {
    ItemModel item = list.items[index];
    bool success = await itemRepository.removeItem(item.id);
    if (success) {
      list.items.removeAt(index);
      filter(searchController.text.trim());
    } else {
      Get.snackbar("Remove item failed", "Please try again later");
    }
  }

  @override
  void reorderElements(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final ItemModel item = list.items.removeAt(oldIndex);
    list.items.insert(newIndex, item);
  }

  @override
  void updateElements(int id, Map<String, dynamic> params) {
    itemRepository.updateItem(id, params);
    filter(searchController.text.trim());
  }

  @override
  void filterElements() {
    // list.items = list.items.where((item) => item.name.contains(searchController.text)).toList().obs;
    // visibleItems = filter(searchController.text);
  }

  void filter(String query) {
    visibleItems =
        list.items.where((item) => item.name.contains(query)).toList().obs;
    print(visibleItems);
    // return list.items.where((item) => item.name.contains(query)).toList();
  }
}
