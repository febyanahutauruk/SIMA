// dashboard_item_response_model.dart
class DashboardItemResponseModel {
  final int? code;
  final bool? isSuccess;
  final String? errorMsg;
  final DashboardItemData data;

  DashboardItemResponseModel({
    this.code,
    this.isSuccess,
    this.errorMsg,
    required this.data,
  });

  factory DashboardItemResponseModel.fromJson(Map<String, dynamic> json) {
    return DashboardItemResponseModel(
      code: json['code'],
      isSuccess: json['isSuccess'],
      errorMsg: json['errorMsg'],
      data: DashboardItemData.fromJson(json['data']),
    );
  }
}

// dashboard_item_data.dart
class DashboardItemData {
  final int itemIn;
  final int itemOut;
  final int underMinQty;

  DashboardItemData({
    required this.itemIn,
    required this.itemOut,
    required this.underMinQty,
  });factory DashboardItemData.fromJson(Map<String, dynamic> json) {
    return DashboardItemData(
      itemIn: json['itemIn'],
      itemOut: json['itemOut'],
      underMinQty: json['underMinQty'],
    );
  }
}