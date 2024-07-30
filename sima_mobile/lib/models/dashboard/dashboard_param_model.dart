// To parse this JSON data, do
//
//     final itemPaginationParamModel = itemPaginationParamModelFromJson(jsonString);

import 'dart:convert';

DashboardPaginationParamModel dashboardPaginationParamModelFromJson(String str) => DashboardPaginationParamModel.fromJson(json.decode(str));

String dashboardPaginationParamModelToJson(DashboardPaginationParamModel data) => json.encode(data.toJson());

class DashboardPaginationParamModel {
  String? warehouseName;

  DashboardPaginationParamModel({
    this.warehouseName,
  });

  DashboardPaginationParamModel copyWith({
    String? warehouseName,
  }) {
    return DashboardPaginationParamModel(
        warehouseName: warehouseName ?? this.warehouseName);
  }

  factory DashboardPaginationParamModel.fromJson(Map<String, dynamic> json) => DashboardPaginationParamModel(
    warehouseName: json["warehouseName"],
  );

  Map<String, dynamic> toJson() => {
    "warehouseName": warehouseName,
  };

}
