import 'package:sima/models/transaction/in_out_model.dart';
import 'package:sima/services/transaction/in_out_service.dart';

class InOutController {
  final InOutService inOutService = InOutService();

  Future<void> addItemInOut(InOutModel item) async {
    await inOutService.addItemInOut(item);
  }
}
