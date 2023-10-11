import 'package:flutter/material.dart';
import 'package:shali_fe/data/controllers/list_elements_controller.dart';

class MySearchBar extends StatelessWidget {
  final ListElementsController controller;
  const MySearchBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SearchBar(
        controller: controller.searchController,
        onChanged: (value) => controller.filterElements(value),
        hintText: "Search",
        elevation: MaterialStateProperty.all(5),
        trailing: const [Icon(Icons.search)],
        leading: controller.searchController.text.isNotEmpty
            ? IconButton(
                onPressed: () => controller.clearSearch(),
                icon: const Icon(Icons.clear))
            : Container(),
      ),
    );
  }
}
