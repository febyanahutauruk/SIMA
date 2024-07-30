import 'package:sima/models/form/update_data_model.dart';
import 'package:sima/services/form/update_data_service.dart';

class UpdateDataController {
  final UpdateDataService _updateDataService = UpdateDataService();

  Future<void> updateItem(UpdateDataModel item) async {
    try {
      await _updateDataService.updateData(item);
    } catch (e) {
      throw Exception('Failed to update item: ${e.toString()}');
    }
  }

  Future<void> deleteItem(int? id) async {
    if (id == null) {
      throw Exception('ID cannot be null');
    }
    try {
      await _updateDataService.deleteItem(id);
    } catch (e) {
      throw Exception('Failed to delete item: ${e.toString()}');
    }
  }
}
