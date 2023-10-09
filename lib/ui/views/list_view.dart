import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shali_fe/data/controllers/list_controller.dart';
import 'package:shali_fe/data/models/item.dart';
import 'package:shali_fe/ui/widgets/default_drawer.dart';
import 'package:shali_fe/ui/widgets/item_card.dart';

class MyListView extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

  MyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<ListController>(
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(controller.list.name),
            ),
            drawer: const DefaultDrawer(),
            body: Center(
                child: Padding(
              padding: const EdgeInsets.all(16),
              child: controller.isLoadingItems
                  ? const CircularProgressIndicator()
                  : mainBody(controller),
            )));
      },
    );
  }

  Column mainBody(ListController controller) {
    List<ItemModel> list = controller.list.items;

    return Column(
      children: [
        Text(controller.list.description),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
          child: Row(
            children: [
              Expanded(
                  child: TextField(
                controller: _nameController,
              )),
              GestureDetector(
                onTap: () {
                  controller.addItem(
                      _nameController.text.trim(), "Questo è un nuovo item");
                  _nameController.clear();
                },
                child: const Icon(Icons.add_box_outlined),
              )
            ],
          ),
        ),
        Expanded(
          child: controller.isMoving
              ? ReorderableListView.builder(
                  itemCount: list.length,
                  onReorder: (oldIndex, newIndex) =>
                      controller.reorderItems(oldIndex, newIndex),
                  itemBuilder: (context, index) => ItemCard(
                        index: index,
                        key: list[index].key,
                      ))
              : ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) => ItemCard(
                        index: index,
                        key: list[index].key,
                      )),
        )
      ],
    );
  }
}
