import 'package:sima/models/form/item_form_model.dart';
import 'package:sima/services/form/item_form_service.dart';

class ItemController {
  final ItemFormService _itemFormService = ItemFormService();

  Future<void> addItem(ItemFormModel item) async {
    await _itemFormService.addItem(item);
  }
}

