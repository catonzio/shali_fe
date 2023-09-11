import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shali_fe/controllers/api_controller.dart';
import 'package:shali_fe/controllers/home_controller.dart';
import 'package:shali_fe/models/list.dart';
import 'package:shali_fe/widgets/default_drawer.dart';
import 'package:shali_fe/widgets/list_card.dart';

class HomeView extends StatelessWidget {
  // final HomeController controller = Get.put(HomeController());
  final TextEditingController _nameController = TextEditingController();

  HomeView({super.key}) {
    // Get.put(HomeController());
  }

  @override
  Widget build(BuildContext context) {
    return GetX<HomeController>(
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: const Text("Your lists"),
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

  Widget mainBody(BuildContext context, HomeController controller) {
    List<ListModel> lists = controller.user.lists;
    return Column(
      children: [
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
                  controller.addList(
                      _nameController.text.trim(), "Questo è una nuova lista");
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
