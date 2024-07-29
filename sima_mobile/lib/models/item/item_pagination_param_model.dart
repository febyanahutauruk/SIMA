// To parse this JSON data, do
//
//     final itemPaginationParamModel = itemPaginationParamModelFromJson(jsonString);

import 'dart:convert';

ItemPaginationParamModel itemPaginationParamModelFromJson(String str) => ItemPaginationParamModel.fromJson(json.decode(str));

String itemPaginationParamModelToJson(ItemPaginationParamModel data) => json.encode(data.toJson());

class ItemPaginationParamModel {
    int limit;
    int offset;
    String? columnIndex;
    String? sortDirection;
    String? code;
    String? name;
    String? categoryName;

    ItemPaginationParamModel({
        required this.limit,
        required this.offset,
        this.columnIndex,
        this.sortDirection,
        this.code,
        this.name,
        this.categoryName,
    });

    ItemPaginationParamModel copyWith({
      int? limit,
      int? offset,
      String? columnIndex,
      String? sortDirection,
      String? code,
      String? name,
      String? categoryName,
    }) {
      return ItemPaginationParamModel(
        limit: limit ?? this.limit, 
        offset: offset ?? this.offset, 
        code: code ?? this.code, 
        name: name ?? this.name, 
        sortDirection: sortDirection ?? this.sortDirection);
    }

    factory ItemPaginationParamModel.fromJson(Map<String, dynamic> json) => ItemPaginationParamModel(
        limit: json["limit"],
        offset: json["offset"],
        columnIndex: json["columnIndex"],
        sortDirection: json["sortDirection"],
        code: json["code"],
        name: json["name"],
        categoryName: json["categoryName"],
    );

    Map<String, dynamic> toJson() => {
        "limit": limit,
        "offset": offset,
        "columnIndex": columnIndex,
        "sortDirection": sortDirection,
        "code": code,
        "name": name,
        "categoryName": categoryName,
    };
    
}
