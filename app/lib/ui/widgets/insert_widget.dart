import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shali_fe/data/controllers/list_elements_controller.dart';
// import 'package:shali_fe/data/controllers/list_controller.dart';

class InsertWidget extends StatelessWidget {
  final ListElementsController controller;

  const InsertWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    //  = Get.find<ListController>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            TextFormField(
              controller: controller.nameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Title"),
              validator: (value) => (value == null || value.isEmpty)
                  ? "Please enter a title"
                  : null,
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: controller.descriptionController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Description"),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (controller.formKey.currentState!.validate()) {
                    bool res = await controller.addElements();
                    if (res) Get.back();
                  }
                },
                child: const Text("Add"))
          ],
        ),
      ),
    );
  }
}
