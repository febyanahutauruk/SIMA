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
    notifyListeners();

    try {
      print("Fetching data...");
      DashboardItemResponseModel responseModel = await _dashboardItemService.getDashboardItemData(param);
      _dashboardItemData = responseModel.data;
      print("Data fetched: $_dashboardItemData");
    } catch (e) {
      print("Error in controller: ${e.toString()}");
    } finally {
      _isLoading = false;
      notifyListeners();
      print("State updated with data: $_dashboardItemData");
    }
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
