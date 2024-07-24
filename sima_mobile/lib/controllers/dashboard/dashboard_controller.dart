import 'package:flutter/material.dart';
import 'package:sima/services/dashboard/dashboard_service.dart';
import 'package:sima/models/dashboard/dashboard_model.dart';
import 'package:sima/models/dashboard/dashboard_param_model.dart';

class DashboardItemController with ChangeNotifier {
  final DashboardItemService _dashboardItemService = DashboardItemService();
  DashboardItemData? _dashboardItemData;

  DashboardItemData? get dashboardItemData => _dashboardItemData;

  DashboardPaginationParamModel param = DashboardPaginationParamModel(warehouseName: ""); // Default to all warehouses

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getDashboardItem() async {
    _isLoading = true;
    DashboardItemResponseModel responseModel = await _dashboardItemService.getDashboardItemData(param);

    print(responseModel);

    _dashboardItemData = responseModel.data;

    _isLoading = false;
    notifyListeners();
  }

  void setWarehouseName(String warehouseName) {
    param = DashboardPaginationParamModel(warehouseName: warehouseName);
    getDashboardItem();
  }

  Future<void> filterItemsByName(String warehouseName) async {
    _isLoading = true;

    param = param.copyWith(warehouseName: warehouseName);

    DashboardItemResponseModel responseModel = await _dashboardItemService
        .getDashboardItemData(param);

    _dashboardItemData = responseModel.data;
    _isLoading = false;

    notifyListeners();
  }
}
