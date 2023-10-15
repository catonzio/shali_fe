import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shali_fe/configs/dimensions.dart';
import 'package:shali_fe/configs/routes.dart';
import 'package:shali_fe/configs/themes.dart';
import 'package:shali_fe/data/controllers/login_controller.dart';
import 'package:shali_fe/ui/widgets/default_drawer.dart';
import 'package:shali_fe/utils.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<LoginController>(
      builder: (controller) {
        return Stack(children: [
          Scaffold(
            appBar: AppBar(),
            drawer: const DefaultDrawer(),
            body: Center(
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(24),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Themes.colorScheme(context).secondaryContainer,
                    ),
                    constraints: BoxConstraints(
                        minWidth: Dimensions.width(context, perc: 25),
                        maxWidth: 600,
                        maxHeight: 600,
                        minHeight: Dimensions.height(context, perc: 25)),
                    width: Dimensions.width(context, perc: 50),
                    height: Dimensions.height(context, perc: 50),
                    padding: const EdgeInsets.all(16),
                    child: buildForm(context, controller)),
              ),
            ),
          ),
          if (controller.isLoading)
            Container(
              color: Colors.transparent,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ]);
      },
    );
  }

  Widget buildForm(BuildContext context, LoginController controller) {
    return Form(
      key: controller.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Login",
              style: Themes.textTheme(context)
                  .headlineLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          TextFormField(
            controller: controller.emailController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: "Email"),
            validator: (value) =>
                !isValidEmail(value ?? "") ? "Insert valid email" : null,
          ),
          TextFormField(
              controller: controller.passwordController,
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
              validator: (value) =>
                  (value == null || value.isEmpty) ? "Insert password" : null),
          ElevatedButton(
              child: const Text("Login"),
              onPressed: () {
                if (controller.formKey.currentState!.validate()) {
                  controller.login();
                }
              }),
          TextButton(
            onPressed: () => Get.toNamed(Routes.register),
            child: const Text("Register"),
          )
        ],
      ),
    );
  }
}
