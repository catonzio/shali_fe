import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shali_fe/configs/dimensions.dart';
import 'package:shali_fe/data/controllers/user_controller.dart';
import 'package:shali_fe/data/models/list.dart';
import 'package:shali_fe/ui/widgets/default_drawer.dart';
import 'package:shali_fe/ui/widgets/insert_widget.dart';
import 'package:shali_fe/ui/widgets/list_card.dart';
import 'package:shali_fe/ui/widgets/my_search_bar.dart';

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
              actions: [
                if (controller.canMove)
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
              bottom: PreferredSize(
                preferredSize:
                    Size.fromHeight(Dimensions.height(context, perc: 10)),
                child: MySearchBar(controller: controller),
              ),
            ),
            floatingActionButton: controller.isMoving
                ? Container()
                : FloatingActionButton(
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

    return controller.isMoving && controller.canMove
        ? ReorderableListView.builder(
            buildDefaultDragHandles: false,
            onReorder: (oldIndex, newIndex) =>
                controller.reorderElements(oldIndex, newIndex),
            itemCount: lists.length,
            itemBuilder: (context, index) => ListCard(
                  index: index,
                  key: lists[index].key,
                ))
        : ListView.builder(
            itemCount: lists.length,
            itemBuilder: (context, index) =>
                ListCard(key: lists[index].key, index: index));
  }
}
