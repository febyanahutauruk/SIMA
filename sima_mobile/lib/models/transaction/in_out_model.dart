// To parse this JSON data, do
//
//     final inOutModel = inOutModelFromJson(jsonString);

import 'dart:convert';

InOutModel inOutModelFromJson(String str) => InOutModel.fromJson(json.decode(str));

String inOutModelToJson(InOutModel data) => json.encode(data.toJson());

class InOutModel {
    String itemName;
    String warehouseName;
    int qtyInOut;
    DateTime date;
    String status;
    int id;
    DateTime createdDate;
    String createdDateFormat;
    String createdBy;
    DateTime updateDate;
    dynamic updateBy;

    InOutModel({
        required this.itemName,
        required this.warehouseName,
        required this.qtyInOut,
        required this.date,
        required this.status,
        required this.id,
        required this.createdDate,
        required this.createdDateFormat,
        required this.createdBy,
        required this.updateDate,
        required this.updateBy,
    });

    factory InOutModel.fromJson(Map<String, dynamic> json) => InOutModel(
        itemName: json["itemName"],
        warehouseName: json["warehouseName"],
        qtyInOut: json["qtyInOut"],
        date: DateTime.parse(json["date"]),
        status: json["status"],
        id: json["id"],
        createdDate: DateTime.parse(json["createdDate"]),
        createdDateFormat: json["createdDateFormat"],
        createdBy: json["createdBy"],
        updateDate: DateTime.parse(json["updateDate"]),
        updateBy: json["updateBy"],
    );

    Map<String, dynamic> toJson() => {
        "itemName": itemName,
        "warehouseName": warehouseName,
        "qtyInOut": qtyInOut,
        "date": date.toIso8601String(),
        "status": status,
        "id": id,
        "createdDate": createdDate.toIso8601String(),
        "createdDateFormat": createdDateFormat,
        "createdBy": createdBy,
        "updateDate": updateDate.toIso8601String(),
        "updateBy": updateBy,
    };
}
