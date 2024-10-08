import 'package:sima/models/item/item_pagination_model.dart';
import 'package:sima/models/item/item_pagination_param_model.dart';
import 'package:sima/models/item/base_pagination_model.dart';
import 'package:sima/services/item/item_service.dart';
import 'package:flutter/material.dart';

class ItemController with ChangeNotifier {
  ItemService service = ItemService();
  List<ItemPaginationModel> _items = [];
  bool _isLoading = true;
  bool _isNext = true;
  ItemPaginationParamModel param = 
    ItemPaginationParamModel (limit: 4, offset: 0);
// test
  List<ItemPaginationModel> get items => _items;
  bool get isNext => _isNext;
  bool get isLoading => _isLoading;

  Future<void> getPaginationItem() async {
    _isLoading = true;
    param = ItemPaginationParamModel (limit: 4, offset: 0);
    ItemPaginationResponseModels responseModel = await service 
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
    ItemPaginationResponseModels responseModel =
    await service.getPaginationItem(param);

    _items = [..._items, ...responseModel.data];
    _isNext = responseModel.isNext;

    notifyListeners();
    }


  Future<void> searchItems() async {
    _isLoading = true;
    ItemPaginationResponseModels responseModel = await service 
      .getPaginationItem(param);
    
    _items = responseModel.data;
    _isNext = responseModel.isNext;
    _isLoading = false;

      notifyListeners();

  }

  Future<void> filterItemsBySort(String sortDirection) async {
    _isLoading = true;

    param = param.copyWith(sortDirection: sortDirection);

    ItemPaginationResponseModels responseModel = await service
        .getPaginationItem(param);

    _items = responseModel.data;
    _isNext = responseModel.isNext;
    _isLoading = false;

    notifyListeners();
  }
}