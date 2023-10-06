import 'package:get/get.dart';
import 'package:shali_fe/api_controllers/api_controller.dart';
import 'package:dio/dio.dart' as dio;
import 'package:shali_fe/models/item.dart';

class ListApiController extends ApiController {
  Future<List<ItemModel>> fetchListItems(int listId) async {
    try {
      dio.Response response = await dioClient.get("/lists/$listId/items");
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
      dio.Response response = await dioClient.post("/items/", data: {
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
      dio.Response response = await dioClient.delete("/items/$itemId");
      return response.statusCode == 200;
    } on dio.DioException catch (e) {
      e.printError();
      return false;
    }
  }

  void updateItem(int id, Map<String, dynamic> params) {
    try {
      dioClient.put("/items/$id", data: params);
    } on dio.DioException catch (e) {
      e.printError();
    } on Exception catch (e) {
      e.printError();
    }
  }
}
