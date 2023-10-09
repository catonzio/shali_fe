import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as dio;
import 'package:shali_fe/configs/constants.dart';

class ClientProvider {
  final dio.Dio dioClient;
  String? apiToken;

  ClientProvider()
      : dioClient = dio.Dio(dio.BaseOptions(baseUrl: Constants.backendUrl));

  // Function to get the API box
  GetStorage apiBox() => GetStorage("api");

  ClientProvider init() {
    String? apiToken = apiBox().read("apiToken");
    refreshToken(apiToken);
    return this;
  }

  void refreshToken(String? apiToken) {
    this.apiToken = apiToken;
    if (apiToken != null) {
      dioClient.options.headers = {"Authorization": "Bearer $apiToken"};
      apiBox().write("apiToken", apiToken);
    } else {
      dioClient.options.headers = {};
      apiBox().remove("apiToken");
    }
  }
}
