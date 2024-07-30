// To parse this JSON data, do
//
//     final itemPaginationModels = itemPaginationModelsFromJson(jsonString);



class HistoryPaginationModel {
  String itemName;
  String warehouseName;
  int qtyInOut;
  // DateTime date;
  String status;
  int id;
  // DateTime createdDate;
  String createdDateFormat;
  // String createdBy;
  // DateTime updateDate;
  // dynamic updateBy;

  HistoryPaginationModel({
    required this.itemName,
    required this.warehouseName,
    required this.qtyInOut,
    // required this.date,
    required this.status,
    required this.id,
    // required this.createdDate,
    required this.createdDateFormat,
    // required this.createdBy,
    // required this.updateDate,
    // required this.updateBy,
  });

  factory HistoryPaginationModel.fromJson(Map<String, dynamic> json) => HistoryPaginationModel(
    itemName: json["itemName"] ??"",
    warehouseName: json["warehouseName"] ??"",
    qtyInOut: json["qtyInOut"] ??"",
    id: json["id"]??"",
    createdDateFormat: json["createdDateFormat"] ??"",
    status: json["status"] ??"",
    // createdDate: DateTime.parse(json["createdDate"]),
    // createdDateFormat: json["createdDateFormat"],
    // createdBy: json["createdBy"],
    // updateDate: DateTime.parse(json["updateDate"]),
    // updateBy: json["updateBy"],
  );


  Map<String, dynamic> toJson() => {
    "itemName": itemName,
    "warehouseName": warehouseName,
    "qtyInOut": qtyInOut,
    "status": status,
    "createdDateFormat": createdDateFormat,
    "id": id,
    // "createdDate": createdDate.toIso8601String(),
    // "createdDateFormat": createdDateFormat,
    // "createdBy": createdBy,
    // "updateDate": updateDate.toIso8601String(),
    // "updateBy": updateBy,
  };
}
