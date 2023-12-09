import 'package:get/get.dart';
import 'package:shali_fe/data/models/list.dart';
import 'package:shali_fe/data/providers/client_provider.dart';
import 'package:dio/dio.dart' as dio;

class ListProvider {
  final ClientProvider client = Get.find<ClientProvider>();

  Future<List<ListModel>> fetchUserLists() async {
    try {
      dio.Response response = await client.dioClient.get("/lists");
      List<ListModel> lists =
          (response.data as List).map((e) => ListModel.fromJson(e)).toList();
      return lists;
    } on dio.DioException catch (e) {
      print(e.error);
      return [];
    } on Exception catch (e) {
      e.printError();
      return [];
    }
  }

  Future<bool> removeList(int listId) async {
    try {
      dio.Response response = await client.dioClient.delete("/lists/$listId");
      return response.statusCode == 200;
    } on dio.DioException catch (e) {
      print(e.error);
      return false;
    }
  }

  void updateList(int id, Map<String, dynamic> params) {
    try {
      client.dioClient.put("/lists/$id", data: params);
    } on dio.DioException catch (e) {
      print(e.error);
    } on Exception catch (e) {
      e.printError();
    }
  }

  Future<bool> addList(ListModel list) async {
    try {
      dio.Response response = await client.dioClient.post("/lists/", data: {
        "name": list.name,
        "description": list.description,
      });
      return response.statusCode == 201;
    } on dio.DioException catch (e) {
      print(e.error);
      return false;
    }
  }

  Future<bool> reorderLists(int oldIndex, int newIndex) async {
    try {
      dio.Response response = await client.dioClient.post("/lists/reorder",
          data: {"old_index": oldIndex, "new_index": newIndex});
      return response.statusCode == 200;
    } on dio.DioException catch (e) {
      e.printError();
      return false;
    }
  }
}
