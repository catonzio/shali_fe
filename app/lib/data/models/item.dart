import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ItemModel {
  final Key key;
  final int id;
  final String name;
  final String description;

  final RxBool _isDone = false.obs;
  bool get isDone => _isDone.value;
  set isDone(bool value) => _isDone.value = value;

  ItemModel(
      {required this.key,
      required this.id,
      required this.name,
      required this.description,
      bool isDone = false}) {
    this.isDone = isDone;
  }

  factory ItemModel.initial() {
    return ItemModel(key: UniqueKey(), id: 0, name: "", description: "");
  }

  factory ItemModel.copyWith({
    Key? key,
    int? id,
    String? name,
    String? description,
    bool? isDone,
  }) {
    return ItemModel(
        key: key ?? UniqueKey(),
        id: id ?? 0,
        name: name ?? "",
        description: description ?? "",
        isDone: isDone ?? false);
  }

  factory ItemModel.fromJson(Map<String, dynamic> dict) {
    return ItemModel(
        key: UniqueKey(),
        id: dict["id"] ?? 0,
        name: dict["name"] ?? "",
        description: dict["description"] ?? "",
        isDone: dict["is_checked"] ?? false);
  }

  @override
  String toString() {
    return name;
  }
}
