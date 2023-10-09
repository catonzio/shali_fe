import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shali_fe/api_controllers/home_api_controller.dart';
import 'package:shali_fe/models/item.dart';
import 'package:shali_fe/models/list.dart';
import 'package:shali_fe/models/user.dart';

class HomeBinding implements Bindings {
// default dependency
  @override
  void dependencies() {
    Get.lazyPut(() => HomeApiController());
    Get.lazyPut(() => HomeController());
  }
}

class HomeController extends GetxController {
  final HomeApiController apiController = Get.find<HomeApiController>();

  final TextEditingController searchController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  User user = User.initial();

  final RxBool _isMoving = false.obs;
  bool get isMoving => _isMoving.value;
  set isMoving(bool value) => _isMoving.value = value;

  final RxBool _isLoadingLists = false.obs;
  bool get isLoadingLists => _isLoadingLists.value;
  set isLoadingLists(bool value) => _isLoadingLists.value = value;

  @override
  Future<void> onInit() async {
    Map<String, dynamic> dict = await apiController.fetchUser();
    user = User.fromJson(dict);
    if (user.lists.isEmpty) {
      isLoadingLists = true;
      List<ListModel> lists = await apiController.fetchUserLists();
      user.lists.addAll(lists);
      isLoadingLists = false;
    }
    super.onInit();
  }

  Future<bool> addList() async {
    String title = nameController.text.trim();
    String description = descriptionController.text.trim();

    if (title.isEmpty) {
      Get.snackbar(
          "Title is empty", "When you add a new list you must specify a title");
      return false;
    } else {
      ListModel list = ListModel(
          key: UniqueKey(),
          id: user.lists.length + 1,
          name: title,
          description: description,
          items: <ItemModel>[].obs);
      bool success = await apiController.addList(list);
      if (success) {
        user.lists.add(list);
        nameController.clear();
        descriptionController.clear();
        return true;
      } else {
        Get.snackbar("Add list failed", "Please try again later");
        return false;
      }
    }
  }

  void removeList(int index) async {
    ListModel list = user.lists[index];
    bool success = await apiController.removeList(list.id);
    if (success) {
      user.lists.removeAt(index);
    } else {
      Get.snackbar("Remove item failed", "Please try again later");
    }
  }

  reorderLists(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final ListModel list = user.lists.removeAt(oldIndex);
    user.lists.insert(newIndex, list);
    apiController.reorderLists(oldIndex, newIndex);
  }

  void updateList(int id, Map<String, dynamic> params) {
    apiController.updateList(id, params);
  }
}
