import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shali_fe/data/controllers/list_controller.dart';
import 'package:shali_fe/data/models/item.dart';
import 'package:shali_fe/ui/widgets/insert_widget.dart';
import 'package:shali_fe/ui/widgets/item_card.dart';
import 'package:shali_fe/ui/widgets/my_search_bar.dart';

class MyListView extends StatelessWidget {
  const MyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<ListController>(
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(controller.list.name),
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
                    Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
                child: MySearchBar(controller: controller),
              ),
            ),
            // drawer: const DefaultDrawer(),
            floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () => Get.defaultDialog(
                      title: "Add item",
                      content: InsertWidget(
                        controller: controller,
                      ),
                    )),
            body: Center(
                child: Padding(
              padding: const EdgeInsets.all(16),
              child: controller.isLoadingElements
                  ? const CircularProgressIndicator()
                  : mainBody(controller),
            )));
      },
    );
  }

  Widget mainBody(ListController controller) {
    List<ItemModel> list = controller.visibleItems;

    return controller.canMove && controller.isMoving
        ? ReorderableListView.builder(
            itemCount: list.length,
            buildDefaultDragHandles: false,
            onReorder: (oldIndex, newIndex) =>
                controller.reorderElements(oldIndex, newIndex),
            itemBuilder: (context, index) => ItemCard(
                  index: index,
                  key: list[index].key,
                ))
        : ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) => ItemCard(
                  index: index,
                  key: list[index].key,
                ));
  }
}
