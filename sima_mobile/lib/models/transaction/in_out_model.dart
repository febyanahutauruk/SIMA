// To parse this JSON data, do
//
//     final inOutModel = inOutModelFromJson(jsonString);

import 'dart:convert';

InOutModel inOutModelFromJson(String str) => InOutModel.fromJson(json.decode(str));

String inOutModelToJson(InOutModel data) => json.encode(data.toJson());

class InOutModel {
    int code;
    bool isSuccess;
    dynamic errorMsg;
    Data data;

    InOutModel({
        required this.code,
        required this.isSuccess,
        required this.errorMsg,
        required this.data,
    });

    factory InOutModel.fromJson(Map<String, dynamic> json) => InOutModel(
        code: json["code"],
        isSuccess: json["isSuccess"],
        errorMsg: json["errorMsg"],
        data: Data.fromJson(json["data"]),
    );

  get item => null;

  get itemCode => null;

    Map<String, dynamic> toJson() => {
        "code": code,
        "isSuccess": isSuccess,
        "errorMsg": errorMsg,
        "data": data.toJson(),
    };
}

class Data {
    WarehouseItem warehouseItem;
    int qty;
    DateTime date;
    String status;
    int id;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic updatedBy;
    String createdBy;
    bool isDeleted;
    bool isActive;

    Data({
        required this.warehouseItem,
        required this.qty,
        required this.date,
        required this.status,
        required this.id,
        required this.createdAt,
        required this.updatedAt,
        required this.updatedBy,
        required this.createdBy,
        required this.isDeleted,
        required this.isActive,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        warehouseItem: WarehouseItem.fromJson(json["warehouseItem"]),
        qty: json["qty"],
        date: DateTime.parse(json["date"]),
        status: json["status"],
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        updatedBy: json["updatedBy"],
        createdBy: json["createdBy"],
        isDeleted: json["isDeleted"],
        isActive: json["isActive"],
    );

    Map<String, dynamic> toJson() => {
        "warehouseItem": warehouseItem.toJson(),
        "qty": qty,
        "date": date.toIso8601String(),
        "status": status,
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "updatedBy": updatedBy,
        "createdBy": createdBy,
        "isDeleted": isDeleted,
        "isActive": isActive,
    };
}

class WarehouseItem {
    Item item;
    Warehouse warehouse;
    int qty;
    int minQty;
    int id;
    DateTime createdAt;
    DateTime updatedAt;
    String updatedBy;
    String createdBy;
    bool isDeleted;
    bool isActive;

    WarehouseItem({
        required this.item,
        required this.warehouse,
        required this.qty,
        required this.minQty,
        required this.id,
        required this.createdAt,
        required this.updatedAt,
        required this.updatedBy,
        required this.createdBy,
        required this.isDeleted,
        required this.isActive,
    });

    factory WarehouseItem.fromJson(Map<String, dynamic> json) => WarehouseItem(
        item: Item.fromJson(json["item"]),
        warehouse: Warehouse.fromJson(json["warehouse"]),
        qty: json["qty"],
        minQty: json["minQty"],
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        updatedBy: json["updatedBy"],
        createdBy: json["createdBy"],
        isDeleted: json["isDeleted"],
        isActive: json["isActive"],
    );

    Map<String, dynamic> toJson() => {
        "item": item.toJson(),
        "warehouse": warehouse.toJson(),
        "qty": qty,
        "minQty": minQty,
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "updatedBy": updatedBy,
        "createdBy": createdBy,
        "isDeleted": isDeleted,
        "isActive": isActive,
    };
}

class Item {
    String name;
    String code;
    String? description;
    Item? category;
    dynamic fileUploads;
    int id;
    DateTime createdAt;
    DateTime updatedAt;
    String updatedBy;
    String createdBy;
    bool isDeleted;
    bool isActive;

    Item({
        required this.name,
        required this.code,
        this.description,
        this.category,
        this.fileUploads,
        required this.id,
        required this.createdAt,
        required this.updatedAt,
        required this.updatedBy,
        required this.createdBy,
        required this.isDeleted,
        required this.isActive,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json["name"],
        code: json["code"],
        description: json["description"],
        category: json["category"] == null ? null : Item.fromJson(json["category"]),
        fileUploads: json["fileUploads"],
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        updatedBy: json["updatedBy"],
        createdBy: json["createdBy"],
        isDeleted: json["isDeleted"],
        isActive: json["isActive"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "description": description,
        "category": category?.toJson(),
        "fileUploads": fileUploads,
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "updatedBy": updatedBy,
        "createdBy": createdBy,
        "isDeleted": isDeleted,
        "isActive": isActive,
    };
}

class Warehouse {
    String code;
    String name;
    String address;
    int latitude;
    int longitude;
    Item location;
    int id;
    DateTime createdAt;
    DateTime updatedAt;
    String updatedBy;
    String createdBy;
    bool isDeleted;
    bool isActive;

    Warehouse({
        required this.code,
        required this.name,
        required this.address,
        required this.latitude,
        required this.longitude,
        required this.location,
        required this.id,
        required this.createdAt,
        required this.updatedAt,
        required this.updatedBy,
        required this.createdBy,
        required this.isDeleted,
        required this.isActive,
    });

    factory Warehouse.fromJson(Map<String, dynamic> json) => Warehouse(
        code: json["code"],
        name: json["name"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        location: Item.fromJson(json["location"]),
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        updatedBy: json["updatedBy"],
        createdBy: json["createdBy"],
        isDeleted: json["isDeleted"],
        isActive: json["isActive"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "location": location.toJson(),
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "updatedBy": updatedBy,
        "createdBy": createdBy,
        "isDeleted": isDeleted,
        "isActive": isActive,
    };
}
