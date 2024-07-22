// To parse this JSON data, do
//
//     final itemPaginationParamModel = itemPaginationParamModelFromJson(jsonString);

import 'dart:convert';

HistoryPaginationParamModel historyPaginationParamModelFromJson(String str) => HistoryPaginationParamModel.fromJson(json.decode(str));

String historyPaginationParamModelToJson(HistoryPaginationParamModel data) => json.encode(data.toJson());

class HistoryPaginationParamModel {
  int limit;
  int offset;
  String? columnIndex;
  String? sortDirection;
  String? itemName;
  String? warehouseName;
  String? status;

  HistoryPaginationParamModel({
    required this.limit,
    required this.offset,
    this.columnIndex,
    this.sortDirection,
    this.itemName,
    this.warehouseName,
    this.status,
  });

  HistoryPaginationParamModel copyWith({
    int? limit,
    int? offset,
    String? columnIndex,
    String? sortDirection,
    String? itemName,
    String? warehouseName,
    String? status,
  }) {
    return HistoryPaginationParamModel(
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        itemName: itemName ?? this.itemName,
        warehouseName: warehouseName ?? this.warehouseName,
        status: status ?? this.status);
  }

  factory HistoryPaginationParamModel.fromJson(Map<String, dynamic> json) => HistoryPaginationParamModel(
    limit: json["limit"],
    offset: json["offset"],
    columnIndex: json["columnIndex"],
    sortDirection: json["sortDirection"],
    itemName: json["itemName"],
    warehouseName: json["warehouseName"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "limit": limit,
    "offset": offset,
    "columnIndex": columnIndex,
    "sortDirection": sortDirection,
    "itemName": itemName,
    "warehouseName": warehouseName,
    "status": status,
  };

}
