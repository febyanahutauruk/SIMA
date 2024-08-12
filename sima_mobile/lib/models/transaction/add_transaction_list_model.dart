import 'dart:io';

class AddTransactionItemModel {
  int? warehouseId;
  int? itemId;
  String aktor;
  int qty;
  int minQty;
  String? ownership;
  String? information;


  AddTransactionItemModel({
  required this.warehouseId,
  required this.itemId,
  required this.aktor,
  required this.qty,
  required this.minQty,
  required this.ownership,
  required this.information,
  });

  factory AddTransactionItemModel.fromJson(Map<String, dynamic> json) => AddTransactionItemModel(
    warehouseId: json["warehouseId"],
    itemId: json["itemId"],
    aktor: json["aktor"],
    qty: json["qty"],
    minQty: json["minQty"],
    ownership: json["ownership"],
    information: json["information"],
  );

  Map<String, dynamic> toJson() => {
    "warehouseId": warehouseId,
    "itemId": itemId,
    "aktor": aktor,
    "qty": qty,
    "minQty": minQty,
    "ownership": ownership,
    "information": information,
  };
}