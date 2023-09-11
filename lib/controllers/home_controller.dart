import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shali_fe/controllers/api_controller.dart';
import 'package:shali_fe/models/item.dart';
import 'package:shali_fe/models/list.dart';
import 'package:shali_fe/models/user.dart';

class HomeBinding implements Bindings {
// default dependency
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}

class HomeController extends GetxController {
  User user = User.initial();

  final RxBool _isMoving = false.obs;
  bool get isMoving => _isMoving.value;
  set isMoving(bool value) => _isMoving.value = value;

  final RxBool _isLoadingLists = false.obs;
  bool get isLoadingLists => _isLoadingLists.value;
  set isLoadingLists(bool value) => _isLoadingLists.value = value;

  @override
  Future<void> onInit() async {
    ApiController apiController = Get.find<ApiController>();
    Map<String, dynamic> dict = await apiController.fetchUser();
    user = User.fromJson(dict);
    if (user.lists.isEmpty) {
      isLoadingLists = true;
      List<ListModel> lists = await Get.find<ApiController>().fetchUserLists();
      user.lists.addAll(lists);
      isLoadingLists = false;
    }
    super.onInit();
  }

  Future<void> addList(String title, String description) async {
    if (title.isEmpty) {
      Get.snackbar(
          "Title is empty", "When you add a new list you must specify a title");
    } else {
      ApiController apiController = Get.find<ApiController>();
      ListModel list = ListModel(
          key: UniqueKey(),
          id: user.lists.length + 1,
          name: title,
          description: description,
          items: <ItemModel>[].obs);
      bool success = await apiController.addList(list);
      if (success) {
        user.lists.add(list);
      } else {
        Get.snackbar("Add list failed", "Please try again later");
      }
    }
  }

  void removeList(int index) async {
    ApiController apiController = Get.find<ApiController>();
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
  }

  void updateList(int id, Map<String, dynamic> params) {
    ApiController apiController = Get.find<ApiController>();
    apiController.updateList(id, params);
  }
}
