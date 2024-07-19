import 'package:sima/models/item/item_pagination_model.dart';
import 'package:sima/models/item/item_pagination_param_model.dart';
import 'package:sima/models/item/base_pagination_model.dart';
import 'package:sima/services/item/item_service.dart';
import 'package:flutter/material.dart';

class ItemController with ChangeNotifier {
  ItemService service = ItemService();
  List<ItemPaginationModel> _items = [];
  int _offset = 0;
  int _limit = 0;
  bool _isLoading = false;
  bool _isNext = true;


  List<ItemPaginationModel> get Items => _items;
  bool get isLoading => _isLoading;

  Future<void> getPaginationItem(ItemPaginationParamModel param) async {
  if (_isNext && !_isLoading) {
    ItemPaginationResponseModels responseModel =
      await service.getPaginationItem(param);

    _offset = _items.length;
    _isNext = responseModel.isNext;
  }

  notifyListeners();

  }
}