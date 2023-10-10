import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shali_fe/data/controllers/user_controller.dart';
import 'package:shali_fe/data/models/list.dart';
import 'package:shali_fe/ui/widgets/default_drawer.dart';
import 'package:shali_fe/ui/widgets/insert_widget.dart';
import 'package:shali_fe/ui/widgets/list_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<UserController>(
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: const Text("Your lists"),
              centerTitle: true,
              actions: [
                if (controller.searchController.text.isEmpty)
                  IconButton(
                    onPressed: () {
                      controller.isMoving = !controller.isMoving;
                    },
                    icon: controller.isMoving
                        ? const Icon(Icons.done)
                        : const Icon(Icons.format_list_numbered_rounded),
                    tooltip: controller.isMoving ? "Done" : "Reorder",
                  )
              ],
            ),
            floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () => Get.defaultDialog(
                    title: "Add list",
                    content: InsertWidget(controller: controller))),
            drawer: const DefaultDrawer(),
            body: Center(
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: controller.isLoadingElements
                        ? const CircularProgressIndicator()
                        : mainBody(controller))));
      },
    );
  }

  Widget mainBody(UserController controller) {
    List<ListModel> lists = controller.visibleLists;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
          child: Row(
            children: [
              Expanded(
                  child: TextField(
                controller: controller.searchController,
                onChanged: (value) => controller.filterElements(value),
              )),
              const Icon(Icons.search),
            ],
          ),
        ),
        Expanded(
          child: controller.isMoving && controller.searchController.text.isEmpty
              ? ReorderableListView.builder(
                  onReorder: (oldIndex, newIndex) =>
                      controller.reorderElements(oldIndex, newIndex),
                  itemCount: lists.length,
                  itemBuilder: (context, index) => ListCard(
                        index: index,
                        key: lists[index].key,
                      ))
              : ListView.builder(
                  itemCount: lists.length,
                  itemBuilder: (context, index) => ListCard(index: index)),
        )
      ],
    );
  }
}
