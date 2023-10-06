import 'package:get/get.dart';
import 'package:shali_fe/api_controllers/api_controller.dart';
import 'package:shali_fe/schemas/login_schema.dart';
import 'package:dio/dio.dart' as dio;

class LoginApiController extends ApiController {
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
}
