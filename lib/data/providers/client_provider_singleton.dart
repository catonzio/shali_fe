import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as dio;
import 'package:shali_fe/configs/constants.dart';

class ClientProviderSingleton {
  // Singleton instance variable
  static final ClientProviderSingleton _instance = ClientProviderSingleton._internal();

  // Private constructor
  ClientProviderSingleton._internal()
      : dioClient = dio.Dio(dio.BaseOptions(baseUrl: Constants.backendUrl));

  // Factory method to access the instance
  factory ClientProviderSingleton() => _instance;

  // Instance variable
  final dio.Dio dioClient;
  bool _initialized = false;
  String? apiToken;

  // Function to get the API box
  GetStorage apiBox() => GetStorage("api");

  ClientProviderSingleton init() {
    if (!_initialized) {
      String? apiToken = apiBox().read("apiToken");
      refreshToken(apiToken);
      _initialized = true;
    }
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
