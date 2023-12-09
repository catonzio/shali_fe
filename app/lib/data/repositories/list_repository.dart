import 'package:shali_fe/data/models/list.dart';
import 'package:shali_fe/data/providers/list_provider.dart';

class ListRepository {
  final ListProvider listProvider;

  ListRepository({required this.listProvider});

  Future<List<ListModel>> fetchUserLists() async {
    return await listProvider.fetchUserLists();
  }

  Future<bool> removeList(int listId) async {
    return await listProvider.removeList(listId);
  }

  void updateList(int id, Map<String, dynamic> params) {
    listProvider.updateList(id, params);
  }

  Future<bool> addList(ListModel list) async {
    return await listProvider.addList(list);
  }

  Future<bool> reorderLists(int oldIndex, int newIndex) async {
    return await listProvider.reorderLists(oldIndex, newIndex);
  }
}
