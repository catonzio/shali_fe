import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as dio;
import 'package:shali_fe/models/item.dart';
import 'package:shali_fe/models/list.dart';
import 'package:shali_fe/schemas/login_schema.dart';

class ApiController extends GetxController {
  static get apiBox => () => GetStorage("api");
  String? apiToken;
  late dio.Dio dioClient;

  @override
  void onInit() {
    apiToken = apiBox().read("apiToken");
    dioClient = dio.Dio(dio.BaseOptions(
        baseUrl: "http://192.168.1.7:3000/api/v1",
        headers:
            apiToken != null ? {"Authorization": "Bearer $apiToken"} : {}));
    super.onInit();
  }

  void setToken(String token) {
    apiToken = token;
    dioClient = dio.Dio(dio.BaseOptions(
        baseUrl: "http://192.168.1.7:3000/api/v1",
        headers:
            apiToken != null ? {"Authorization": "Bearer $apiToken"} : {}));
    apiBox().write("apiToken", apiToken);
  }

  void clearToken() {
    apiToken = null;
    apiBox().remove("apiToken");
  }

  Uri buildUri(String path, {Map<String, String>? params}) {
    Uri res = Uri.https("http://192.168.1.7:3000/api/v1", path);
    if (params != null) {
      res.replace(queryParameters: params);
    }
    return res;
  }

  Future<LoginSchema> login(String email, String password) async {
    if (apiToken != null && apiToken!.isNotEmpty) {
      return LoginSchema(success: true, apiToken: apiToken!);
    } else {
      try {
        final formData =
            dio.FormData.fromMap({'username': email, 'password': password});
        dio.Response response =
            await dioClient.post("/auth/token", data: formData);

        setToken(response.data["access_token"]);
        return LoginSchema(success: true, apiToken: apiToken ?? "");
      } on dio.DioException catch (e) {
        e.printError();
        // get error code
        int statusCode = e.response?.statusCode ?? 500;
        // incorrect email or password
        if (statusCode == 400 || statusCode == 401) {
          return LoginSchema(success: false);
        }
        // if one is missing
        if (statusCode == 422) {
          return LoginSchema(success: false, fieldMissing: true);
        }
        return LoginSchema();
      }
    }
  }

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
      print(response.data);
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

  Future<bool> removeList(int listId) async {
    try {
      dio.Response response = await dioClient.delete("/lists/$listId");
      return response.statusCode == 200;
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

  void updateList(int id, Map<String, dynamic> params) {
    try {
      dioClient.put("/lists/$id", data: params);
    } on dio.DioException catch (e) {
      e.printError();
    } on Exception catch (e) {
      e.printError();
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

  logout() {
    clearToken();
    Get.offAllNamed("/login");
  }
}
