import 'package:sima/models/history/history_pagination_model.dart';
import 'package:sima/models/history/history_pagination_param_model.dart';
import 'package:sima/models/history/base_pagination_model.dart';
import 'package:sima/services/history/history_service.dart';
import 'package:flutter/material.dart';

class HistoryController with ChangeNotifier {
  HistoryService service = HistoryService();
  List<HistoryPaginationModel> _items = [];
  bool _isLoading = true;
  bool _isNext = true;
  HistoryPaginationParamModel param =
  HistoryPaginationParamModel (limit: 8, offset: 0);
// test
  List<HistoryPaginationModel> get items => _items;
  bool get isNext => _isNext;
  bool get isLoading => _isLoading;

  Future<void> getPaginationItem() async {
    _isLoading = true;
    param = HistoryPaginationParamModel (limit: 8, offset: 0);
    HistoryPaginationResponseModels responseModel = await service
        .getPaginationItem(param);

    print(responseModel);

    _items = responseModel.data;
    _isNext = responseModel.isNext;
    _isLoading = false;

    notifyListeners();

  }

  Future <void> loadMore() async {
    print("limit ${param.limit}");
    //param = param.copyWith(limit = 2, offset = _items.length);
    HistoryPaginationResponseModels responseModel =
    await service.getPaginationItem(param);

    _items = [..._items, ...responseModel.data];
    _isNext = responseModel.isNext;

    notifyListeners();
  }


  Future<void> searchItems() async {
    _isLoading = true;
    HistoryPaginationResponseModels responseModel = await service
        .getPaginationItem(param);

    _items = responseModel.data;
    _isNext = responseModel.isNext;
    _isLoading = false;

    notifyListeners();

  }

  Future<void> filterItemsByStatus(String status) async {
    _isLoading = true;

    param = param.copyWith(status: status);

    HistoryPaginationResponseModels responseModel = await service
        .getPaginationItem(param);

    _items = responseModel.data;
    _isNext = responseModel.isNext;
    _isLoading = false;

    notifyListeners();
  }
}