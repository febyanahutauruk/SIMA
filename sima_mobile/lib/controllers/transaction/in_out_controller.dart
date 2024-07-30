import 'package:flutter/material.dart';
import 'package:sima/models/transaction/transaction_pagination_model.dart';
import 'package:sima/services/transaction/in_out_service.dart';

class InOutController {
  final InOutService _service = InOutService();

  Future<void> addItemInOut(BuildContext context, TransactionPaginationModel model) async {
    try {
      final result = await _service.addItemInOut(model);
      if (result != null && result.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Item ${model.status} successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to process the request')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}
