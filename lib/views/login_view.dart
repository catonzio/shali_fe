import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shali_fe/controllers/api_controller.dart';
import 'package:shali_fe/controllers/login_controller.dart';
import 'package:shali_fe/widgets/default_drawer.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<LoginController>(
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              title: const Text("Login"),
            ),
            drawer: const DefaultDrawer(),
            body: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(64),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("token: ${Get.find<ApiController>().apiToken}"),
                  MaterialButton(
                    onPressed: () {
                      Get.find<ApiController>().clearToken();
                    },
                    child: Text("Clear"),
                  ),
                  Column(
                    children: [
                      TextField(
                          controller: controller.emailController,
                          decoration: const InputDecoration(hintText: "email")),
                      TextField(
                        controller: controller.passwordController,
                        decoration: InputDecoration(
                            hintText: "password",
                            suffix: IconButton(
                              padding: const EdgeInsets.all(0),
                              icon: Icon(controller.isPasswordObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () => controller.isPasswordObscure =
                                  !controller.isPasswordObscure,
                            )),
                        obscureText: controller.isPasswordObscure,
                      ),
                    ],
                  ),
                  ElevatedButton(
                      child: const Text("Login"),
                      onPressed: () => controller.login()),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Register"),
                  )
                ],
              ),
            ));
      },
    );
  }
}
