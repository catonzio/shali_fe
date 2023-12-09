import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shali_fe/data/controllers/register_controller.dart';
import 'package:shali_fe/utils.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<RegisterController>(
      builder: (controller) => body(context, controller),
    );
  }

  Scaffold body(BuildContext context, RegisterController controller) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(64),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                            controller: controller.nameController,
                            validator: (value) =>
                                (value == null || value.isEmpty)
                                    ? "Please enter a name"
                                    : null,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Name")),
                        TextFormField(
                            controller: controller.emailController,
                            validator: (value) => !isValidEmail(value ?? "")
                                ? "Please enter a valid email"
                                : null,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Email")),
                        TextFormField(
                          controller: controller.passwordController,
                          validator: (value) => (value == null || value.isEmpty)
                              ? "Please enter a password"
                              : null,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: "Password",
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
                        TextFormField(
                          controller: controller.passwordConfirmController,
                          validator: (value) => (value == null || value.isEmpty)
                              ? "Please enter a password"
                              : (value !=
                                      controller.passwordController.text.trim())
                                  ? "Passwords do not match"
                                  : null,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: "Confirm Password",
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
                    ))),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        child: const Text("Register"),
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                            controller.register();
                          }
                        }),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
