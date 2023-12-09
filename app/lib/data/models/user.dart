import 'package:get/get.dart';
import 'package:shali_fe/data/models/list.dart';

class User {
  final int id;
  final String name;
  final String email;
  final RxList<ListModel> lists;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.lists});

  factory User.initial() {
    return User(id: 0, name: "", email: "", lists: <ListModel>[].obs);
  }

  factory User.copyWith({
    int? id,
    String? name,
    String? email,
    RxList<ListModel>? lists,
  }) {
    return User(
        id: id ?? 0,
        name: name ?? "",
        email: email ?? "",
        lists: lists ?? <ListModel>[].obs);
  }

  factory User.fromJson(Map<String, dynamic> dict) {
    RxList<ListModel> lists;
    if (!dict.containsKey("lists") || dict["lists"] == null) {
      lists = <ListModel>[].obs;
    } else {
      lists = (dict["lists"] as List<dynamic>)
          .map((e) => ListModel.fromJson(e))
          .toList()
          .obs;
    }
    return User(
        id: dict["id"],
        name: dict["username"],
        email: dict["email"],
        lists: lists);
  }
}
