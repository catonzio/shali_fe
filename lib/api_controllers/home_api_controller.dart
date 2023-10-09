import 'package:get/get.dart';
import 'package:shali_fe/api_controllers/api_controller.dart';
import 'package:shali_fe/models/list.dart';
import 'package:dio/dio.dart' as dio;

class HomeApiController extends ApiController {
  Future<Map<String, dynamic>> fetchUser() async {
    try {
      dio.Response response = await dioClient.get("/users/me");
      return response.data;
    } on dio.DioException catch (e) {
      e.printError();
      clearToken();
      return {};
    }
  }

  Future<List<ListModel>> fetchUserLists() async {
    try {
      dio.Response response = await dioClient.get("/lists");
      List<ListModel> lists =
          (response.data as List).map((e) => ListModel.fromJson(e)).toList();
      return lists;
    } on dio.DioException catch (e) {
      e.printError();
      return [];
    } on Exception catch (e) {
      e.printError();
      return [];
    }
  }

  Future<bool> removeList(int listId) async {
    try {
      dio.Response response = await dioClient.delete("/lists/$listId");
      return response.statusCode == 200;
    } on dio.DioException catch (e) {
      e.printError();
      return false;
    }
  }

  void updateList(int id, Map<String, dynamic> params) {
    try {
      dioClient.put("/lists/$id", data: params);
    } on dio.DioException catch (e) {
      e.printError();
    } on Exception catch (e) {
      e.printError();
    }
  }

  Future<bool> addList(ListModel list) async {
    try {
      dio.Response response = await dioClient.post("/lists/", data: {
        "name": list.name,
        "description": list.description,
      });
      return response.statusCode == 201;
    } on dio.DioException catch (e) {
      e.printError();
      return false;
    }
  }

  void logout() {
    clearToken();
    Get.offAllNamed("/login");
  }

  Future<bool> reorderLists(int oldIndex, int newIndex) async {
    try {
      dio.Response response = await dioClient.post("/lists/reorder",
          data: {"old_index": oldIndex, "new_index": newIndex});
      return response.statusCode == 200;
    } on dio.DioException catch (e) {
      e.printError();
      return false;
    }
  }
}
