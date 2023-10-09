import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shali_fe/data/controllers/user_controller.dart';
import 'package:shali_fe/data/models/list.dart';
import 'package:shali_fe/ui/widgets/default_drawer.dart';
import 'package:shali_fe/ui/widgets/list_card.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key}) {
    // Get.put(HomeController());
  }

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
                  content: Column(
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
                            border: OutlineInputBorder(),
                            labelText: "Description"),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            bool res = await controller.addList();
                            if (res) Get.back();
                          },
                          child: const Text("Add"))
                    ],
                  )),
            ),
            drawer: const DefaultDrawer(),
            body: Center(
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: controller.isLoadingLists
                        ? const CircularProgressIndicator()
                        : mainBody(context, controller))));
      },
    );
  }

  Widget mainBody(BuildContext context, UserController controller) {
    List<ListModel> lists = controller.lists;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
          child: Row(
            children: [
              Expanded(
                  child: TextField(
                controller: controller.searchController,
              )),
              const Icon(Icons.search),
            ],
          ),
        ),
        Expanded(
          child: controller.isMoving
              ? ReorderableListView.builder(
                  onReorder: (oldIndex, newIndex) =>
                      controller.reorderLists(oldIndex, newIndex),
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
