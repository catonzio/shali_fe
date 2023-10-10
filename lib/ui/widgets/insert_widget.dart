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
    return Column(
      children: [
        TextField(
          controller: controller.nameController,
          decoration: const InputDecoration(
              border: OutlineInputBorder(), labelText: "Title"),
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
              bool res = await controller.addElements();
              if (res) Get.back();
            },
            child: const Text("Add"))
      ],
    );
  }
}
