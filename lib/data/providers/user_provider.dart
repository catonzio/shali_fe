import 'package:get/get.dart';
import 'package:shali_fe/data/models/api_results.dart';
import 'package:shali_fe/data/providers/client_provider.dart';
import 'package:shali_fe/data/schemas/login_schema.dart';
import 'package:dio/dio.dart' as dio;

class UserProvider {
  final ClientProvider client = Get.find<ClientProvider>();

  Future<LoginSchema> login(String email, String password) async {
    if (client.apiToken != null && client.apiToken!.isNotEmpty) {
      return LoginSchema(success: true, apiToken: client.apiToken!);
    } else {
      try {
        final formData =
            dio.FormData.fromMap({'username': email, 'password': password});
        dio.Response response =
            await client.dioClient.post("/auth/token", data: formData);
        client.refreshToken(response.data["access_token"]);

        return LoginSchema(success: true, apiToken: client.apiToken ?? "");
      } on dio.DioException catch (e) {
        print(e.error);
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

  void logout() {
    client.refreshToken(null);
    Get.offAllNamed("/login");
  }

  Future<Map<String, dynamic>> fetchUser() async {
    try {
      dio.Response response = await client.dioClient.get("/users/me");
      return response.data;
    } on dio.DioException catch (e) {
      e.printError();
      client.refreshToken(null);
      return {};
    }
  }

  Future<ApiResults> register(
      String name, String email, String password) async {
    try {
      dio.Response response = await client.dioClient.post("/users/register",
          data: {"username": name, "email": email, "password": password});
      if (response.statusCode == 201) {
        LoginSchema loginSchema = await login(email, password);
        if (loginSchema.success) {
          return ApiResults(success: true, results: loginSchema.apiToken);
        }
      }
      return ApiResults(success: false, results: "Login failed");
    } on dio.DioException catch (e) {
      return ApiResults(success: false, results: e.message);
    }
  }
}
