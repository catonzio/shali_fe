import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:shali_fe/api_controllers/api_controller.dart';
import 'package:shali_fe/api_controllers/login_api_controller.dart';
import 'package:shali_fe/models/api_results.dart';
import 'package:shali_fe/schemas/login_schema.dart';

class RegisterApiController extends ApiController {
  Future<ApiResults> register(
      String name, String email, String password) async {
    try {
      dio.Response response = await dioClient.post("/users/register",
          data: {"username": name, "email": email, "password": password});
      if (response.statusCode == 201) {
        LoginSchema loginSchema =
            await Get.find<LoginApiController>().login(email, password);
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
