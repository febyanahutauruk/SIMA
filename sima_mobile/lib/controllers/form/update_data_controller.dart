import 'package:sima/models/form/update_data_model.dart';
import 'package:sima/services/form/update_data_service.dart';

class UpdateDataController {
  final UpdateDataService _UpdateDataService = UpdateDataService();

  Future<void> updateItem(UpdateDataModel item) async {
    try {
      await _UpdateDataService.updateData(item);
    } catch (e) {
      throw Exception('Failed to update item: $e');
    }
  }
}
