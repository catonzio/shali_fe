import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as dio;

class ApiController extends GetxController {
  static get apiBox => () => GetStorage("api");
  String? apiToken;
  late dio.Dio dioClient;

  @override
  void onInit() {
    apiToken = apiBox().read("apiToken");
    dioClient = dio.Dio(dio.BaseOptions(
        baseUrl: "http://192.168.1.7:3500/shali/api",
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

  
}
