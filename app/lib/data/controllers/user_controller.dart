import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shali_fe/data/controllers/list_elements_controller.dart';
import 'package:shali_fe/data/models/item.dart';
import 'package:shali_fe/data/models/list.dart';
import 'package:shali_fe/data/repositories/list_repository.dart';

class UserController extends ListElementsController {
  final ListRepository listRepository;

  late RxList<ListModel> originalLists;

  final RxList<ListModel> _visibleLists = <ListModel>[].obs;
  List<ListModel> get visibleLists => _visibleLists;
  set visibleLists(List<ListModel> value) => _visibleLists.value = value;

  @override
  bool get canMove => searchController.text.isEmpty && visibleLists.length > 1;

  UserController({required this.listRepository});

  @override
  Future<void> onInit() async {
    isLoadingElements = true;
    originalLists = (await listRepository.fetchUserLists()).obs;
    visibleLists = originalLists;
    isLoadingElements = false;
    super.onInit();
  }

  @override
  Future<bool> addElements() async {
    String title = nameController.text.trim();
    String description = descriptionController.text.trim();

    if (title.isEmpty) {
      Get.snackbar(
          "Title is empty", "When you add a new list you must specify a title");
      return false;
    } else {
      ListModel list = ListModel(
          key: UniqueKey(),
          id: originalLists.length + 1,
          name: title,
          description: description,
          items: <ItemModel>[].obs);
      bool success = await listRepository.addList(list);
      if (success) {
        originalLists.add(list);
        filterElements(searchController.text.trim());
        nameController.clear();
        descriptionController.clear();
        return true;
      } else {
        Get.snackbar("Add list failed", "Please try again later");
        return false;
      }
    }
  }

  @override
  void removeElements(int index) async {
    ListModel list = visibleLists[index];
    bool success = await listRepository.removeList(list.id);
    if (success) {
      originalLists.removeAt(index);
      filterElements(searchController.text.trim());
    } else {
      Get.snackbar("Remove item failed", "Please try again later");
    }
  }

  @override
  reorderElements(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final ListModel list = visibleLists.removeAt(oldIndex);
    visibleLists.insert(newIndex, list);
    listRepository.reorderLists(oldIndex, newIndex);
  }

  @override
  void updateElements(int id, Map<String, dynamic> params) {
    listRepository.updateList(id, params);
    filterElements(searchController.text.trim());
  }

  @override
  void filterElements(String query) {
    visibleLists = originalLists
        .where((list) => list.name.contains(searchController.text.trim()))
        .toList()
        .obs;
  }
}
