import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            body: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                padding: const EdgeInsets.all(64),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        TextField(
                            controller: controller.emailController,
                            decoration:
                                const InputDecoration(hintText: "email")),
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
                    const Spacer(),
                    ElevatedButton(
                        child: const Text("Login"),
                        onPressed: () => controller.login()),
                    const Spacer(),
                    TextButton(
                      onPressed: () => Get.toNamed("/register"),
                      child: const Text("Register"),
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}
