import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shali_fe/data/controllers/list_controller.dart';
import 'package:shali_fe/data/models/item.dart';
import 'package:shali_fe/configs/styles.dart';
import 'dart:math' as math;

class ItemCard extends StatelessWidget {
  final int index;

  const ItemCard({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<ListController>(builder: (controller) {
      ItemModel item = controller.visibleItems[index];
      TextStyle style = item.isDone ? checkedStyle : const TextStyle();

      return Dismissible(
        key: item.key,
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
            controller.removeElements(index),
        child: GestureDetector(
          onLongPress: () => controller.isMoving = !controller.isMoving,
          onTap: () => Get.dialog(ItemCardDialog(index: index)),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
                leading: Checkbox(
                  value: item.isDone,
                  onChanged: (value) {
                    controller.updateElements(item.id, {'is_checked': value});
                    item.isDone = value!;
                  },
                ),
                title: Text(
                  item.name,
                  style: style,
                ),
                subtitle: Text(
                  item.description,
                  style: style,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: controller.isMoving
                    ? ReorderableDragStartListener(
                        index: index,
                        child: const Icon(Icons.drag_handle_sharp),
                      )
                    : Container(
                        width: 10,
                      )),
          ),
        ),
      );
    });
  }
}

class ItemCardDialog extends StatelessWidget {
  final int index;
  const ItemCardDialog({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetX<ListController>(
      builder: (controller) {
        ItemModel item = controller
            .list.items[math.min(controller.list.items.length - 1, index)];
        return AlertDialog(
          title: Text(item.name),
          content: Text(item.description),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text("Close"),
            ),
            TextButton(
              onPressed: () {
                controller.removeElements(index);
                Get.back();
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
