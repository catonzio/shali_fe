import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shali_fe/controllers/register_controller.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<RegisterController>(
      builder: (controller) => body(context, controller),
    );
  }

  Scaffold body(BuildContext context, RegisterController controller) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        centerTitle: true,
      ),
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(64),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                  controller: controller.nameController,
                  decoration: const InputDecoration(hintText: "name")),
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
              TextField(
                controller: controller.passwordConfirmController,
                decoration: InputDecoration(
                    hintText: "confirm password",
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
              ElevatedButton(
                  child: const Text("Login"),
                  onPressed: () => controller.register()),
            ],
          )),
    );
  }
}
