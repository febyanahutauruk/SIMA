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
        notifyListeners(); 
      }
    }
  }

  Future<void> searchItems(String itemName) async {
    _isLoading = true;
    notifyListeners(); 

    try {
      param = param.copyWith(itemName: itemName, offset: 0); 
      TransactionPaginationResponseModel responseModel = await service.getPaginationTransaction(param);

      print("Response from searchItems: $responseModel");

      _items = responseModel.data;
      _isNext = responseModel.isNext;
    } catch (e) {
      print('Error searching items: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> addItemInOut(TransactionPaginationModel item) async {
    if (item.qtyInOut <= 0) {
      throw Exception("qtyInOut must be greater than 0");
    }
    try {
      TransactionParamModel itemInOut = TransactionParamModel(
        limit: 4,
        offset: 0,
        id: item.id,
        itemName: item.itemName,
        itemCategory: item.itemCategory,
        qty: item.qtyInOut,
        qtyInOut: item.qtyInOut, 
      );

      await service.addItemInOut(itemInOut);
    } catch (e) {
      print('Error adding item in/out: $e');
      throw e; 
    }
  }

  Future<void> filterItemsByCategory(String itemCategory) async {
    _isLoading = true;
    notifyListeners();

    param = param.copyWith(itemCategory: itemCategory, offset: 0);
    TransactionPaginationResponseModel responseModel = await service.getPaginationTransaction(param);

    _items = responseModel.data;
    _isNext = responseModel.isNext;
    _isLoading = false;

    notifyListeners();
  }
}

