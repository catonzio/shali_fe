import 'package:shali_fe/data/models/api_results.dart';
import 'package:shali_fe/data/providers/user_provider.dart';
import 'package:shali_fe/data/schemas/login_schema.dart';

class UserRepository {
  final UserProvider userProvider;

  UserRepository({required this.userProvider});

  Future<LoginSchema> login(String email, String password) async {
    return await userProvider.login(email, password);
  }

  void logout() {
    userProvider.logout();
  }

  Future<Map<String, dynamic>> fetchUser() async {
    return await userProvider.fetchUser();
  }

  Future<ApiResults> register(
      String name, String email, String password) async {
    return await userProvider.register(name, email, password);
  }
}
