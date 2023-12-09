import 'package:get/get.dart';
import 'package:shali_fe/data/models/item.dart';
import 'package:shali_fe/data/providers/client_provider.dart';
import 'package:dio/dio.dart' as dio;

class ItemProvider {
  final ClientProvider client = Get.find<ClientProvider>();

  Future<List<ItemModel>> fetchListItems(int listId) async {
    try {
      dio.Response response =
          await client.dioClient.get("/lists/$listId/items");
      List<ItemModel> items =
          (response.data as List).map((e) => ItemModel.fromJson(e)).toList();
      return items;
    } on dio.DioException catch (e) {
      e.printError();
      return [];
    } on Exception catch (e) {
      e.printError();
      return [];
    }
  }

  Future<bool> addItem(int listId, ItemModel item) async {
    try {
      dio.Response response = await client.dioClient.post("/items/", data: {
        "name": item.name,
        "description": item.description,
        "list_id": listId
      });
      return response.statusCode == 201;
    } on dio.DioException catch (e) {
      e.printError();
      return false;
    }
  }

  Future<bool> removeItem(int itemId) async {
    try {
      dio.Response response = await client.dioClient.delete("/items/$itemId");
      return response.statusCode == 200;
    } on dio.DioException catch (e) {
      e.printError();
      return false;
    }
  }

  void updateItem(int id, Map<String, dynamic> params) {
    try {
      client.dioClient.put("/items/$id", data: params);
    } on dio.DioException catch (e) {
      e.printError();
    } on Exception catch (e) {
      e.printError();
    }
  }

  Future<bool> reorderItems(int oldIndex, int newIndex) async {
    try {
      dio.Response response = await client.dioClient.post("/items/reorder",
          data: {"old_index": oldIndex, "new_index": newIndex});
      return response.statusCode == 200;
    } on dio.DioException catch (e) {
      e.printError();
      return false;
    }
  }
}
