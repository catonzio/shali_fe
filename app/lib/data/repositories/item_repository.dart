import 'package:shali_fe/data/models/item.dart';
import 'package:shali_fe/data/providers/item_provider.dart';

class ItemRepository {
  final ItemProvider itemProvider;

  ItemRepository(this.itemProvider);

  Future<List<ItemModel>> fetchListItems(int listId) async {
    return await itemProvider.fetchListItems(listId);
  }

  Future<bool> addItem(int listId, ItemModel item) async {
    return await itemProvider.addItem(listId, item);
  }

  Future<bool> removeItem(int itemId) async {
    return await itemProvider.removeItem(itemId);
  }

  void updateItem(int id, Map<String, dynamic> params) {
    itemProvider.updateItem(id, params);
  }

  Future<bool> reorderItems(int oldIndex, int newIndex) async {
    return await itemProvider.reorderItems(oldIndex, newIndex);
  }
}
