import 'package:flutter/material.dart';
import 'package:sima/models/transaction/transaction_base_pagination_model.dart';
import 'package:sima/models/transaction/transaction_pagination_model.dart';
import 'package:sima/models/transaction/transaction_param_model.dart';
import 'package:sima/services/transaction/transaction_service.dart';

class TransactionController with ChangeNotifier {
  final TransactionService service = TransactionService();
  List<TransactionPaginationModel> _items = [];
  bool _isLoading = true;
  bool _isNext = true;
  TransactionParamModel param = TransactionParamModel(limit: 6, offset: 0);

  List<TransactionPaginationModel> get items => _items;
  bool get isNext => _isNext;
  bool get isLoading => _isLoading;

  Future<void> getPaginationTransaction() async {
    _isLoading = true;
    param = TransactionParamModel(limit: 6, offset: 0);
    try {
      TransactionPaginationResponseModel responseModel = await service.getPaginationTransaction(param);
      print("Response from getPaginationTransaction: $responseModel");

      _items = responseModel.data;
      _isNext = responseModel.isNext;
    } catch (e) {
      print('Error fetching transactions: $e');
    } finally {
      _isLoading = false;
      notifyListeners(); 
    }
  }

  Future<void> loadMore() async {
    if (_isNext && !_isLoading) {
      _isLoading = true;
      try {
        param = param.copyWith(offset: _items.length); // Use current items length for offset
        TransactionPaginationResponseModel responseModel = await service.getPaginationTransaction(param);

        print("Response from loadMore: $responseModel");

        _items = [..._items, ...responseModel.data];
        _isNext = responseModel.isNext;
      } catch (e) {
        print('Error loading more transactions: $e');
      } finally {
        _isLoading = false;
        notifyListeners(); // Notify listeners to update UI
      }
    }
  }

  Future<void> searchItems(String itemName) async {
    _isLoading = true;
    notifyListeners(); // Notify listeners to show loading state

    try {
      param = param.copyWith(itemName: itemName, offset: 0); // Reset offset for search
      TransactionPaginationResponseModel responseModel = await service.getPaginationTransaction(param);

      print("Response from searchItems: $responseModel");

      _items = responseModel.data;
      _isNext = responseModel.isNext;
    } catch (e) {
      print('Error searching items: $e');
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify listeners to update UI
    }
  }
}
