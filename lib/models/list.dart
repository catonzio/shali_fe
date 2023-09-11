import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shali_fe/models/item.dart';

class ListModel {
  final Key key;
  final int id;
  final String name;
  final String description;
  final RxList<ItemModel> items;

  final RxBool _isDone = false.obs;
  bool get isDone => _isDone.value;
  set isDone(bool value) => _isDone.value = value;

  ListModel(
      {required this.key,
      required this.id,
      required this.name,
      required this.description,
      required this.items,
      bool isDone = false}) {
    this.isDone = isDone;
  }

  factory ListModel.initial() {
    return ListModel(
        key: UniqueKey(),
        id: 0,
        name: "",
        description: "",
        items: RxList<ItemModel>());
  }

  factory ListModel.copyWith({
    Key? key,
    int? id,
    String? name,
    String? description,
    RxList<ItemModel>? items,
    bool? isDone,
  }) {
    return ListModel(
        key: key ?? UniqueKey(),
        id: id ?? 0,
        name: name ?? "",
        description: description ?? "",
        items: items ?? <ItemModel>[].obs,
        isDone: isDone ?? false);
  }

  factory ListModel.fromJson(Map<String, dynamic> dict) {
    RxList<ItemModel> items;
    if (dict["items"] == null) {
      items = <ItemModel>[].obs;
    } else {
      items = (dict["items"] as List<dynamic>)
          .map((e) => ItemModel.fromJson(e))
          .toList()
          .obs;
    }
    return ListModel(
        key: UniqueKey(),
        id: dict["id"] ?? 0,
        name: dict["name"] ?? "",
        description: dict["description"] ?? "",
        items: items,
        isDone: dict["is_checked"] ?? false);
  }
}
