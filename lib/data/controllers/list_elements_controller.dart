import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class ListElementsController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final RxBool _isMoving = false.obs;
  bool get isMoving => _isMoving.value;
  set isMoving(bool value) => _isMoving.value = value;

  final RxBool _isLoadingElements = false.obs;
  bool get isLoadingLists => _isLoadingElements.value;
  set isLoadingLists(bool value) => _isLoadingElements.value = value;

  Future<bool> addElements();
  void removeElements(int index);
  void reorderElements(int oldIndex, int newIndex);
  void updateElements(int id, Map<String, dynamic> params);
  void filterElements();
}
