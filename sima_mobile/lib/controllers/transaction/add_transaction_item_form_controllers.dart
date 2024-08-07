import 'package:sima/models/transaction/add_transaction_list_model.dart';
import 'package:sima/services/transaction/add_transaction_item_form_service.dart';

class AddTransactionItemFormControllers {
  final AddTransactionItemFormService _addTransactionItemFormService = AddTransactionItemFormService();

  Future<void> addItem(AddTransactionItemModel item) async {
    await _addTransactionItemFormService.addItem(item);
  }
}
