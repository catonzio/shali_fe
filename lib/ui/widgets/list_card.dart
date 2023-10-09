import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shali_fe/data/controllers/user_controller.dart';
import 'package:shali_fe/data/controllers/list_controller.dart';
import 'package:shali_fe/data/models/list.dart';
import 'package:shali_fe/configs/styles.dart';

class ListCard extends StatelessWidget {
  final int index;
  const ListCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetX<UserController>(
      builder: (controller) {
        ListModel list = controller.lists[index];
        TextStyle style = list.isDone ? checkedStyle : const TextStyle();

        return Dismissible(
          key: list.key,
          background: const Card(color: Colors.red),
          direction: DismissDirection.startToEnd,
          confirmDismiss: (direction) => Get.dialog(AlertDialog(
            title: const Text("Delete Confirmation"),
            content: const Text("Are you sure you want to delete this item?"),
            actions: [
              TextButton(
                  onPressed: () => Get.back(result: false),
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () => Get.back(result: true),
                  child: const Text("Delete")),
            ],
          )),
          onDismissed: (DismissDirection direction) =>
              controller.removeList(index),
          child: GestureDetector(
            onLongPress: () => controller.isMoving = !controller.isMoving,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Checkbox(
                  value: list.isDone,
                  onChanged: (value) {
                    controller.updateList(list.id, {'is_checked': value});
                    list.isDone = value!;
                  },
                ),
                title: Text(list.name, style: style),
                subtitle: Text(list.description, style: style),
                onTap: () => Get.toNamed(
                  "/list",
                  arguments: list,
                )?.then((value) => Get.delete<ListController>()),
                trailing: controller.isMoving
                    ? ReorderableDragStartListener(
                        index: index,
                        child: const Icon(Icons.drag_handle_sharp),
                      )
                    : Container(
                        width: 10,
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
