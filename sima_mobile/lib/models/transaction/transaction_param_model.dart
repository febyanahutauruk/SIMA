import 'dart:convert';

TransactionParamModel transactionItemParamModelFromJson(String str) => TransactionParamModel.fromJson(json.decode(str));
String transactionParamModelToJson(TransactionParamModel data) => json.encode(data.toJson());

class TransactionParamModel {
  int limit;
  int offset;
  String? itemName;
  String? itemCategory;
  int? qty;
  int? minQty;
  String? warehouseName;
  String? address;
  String? description;
  int? idFileUploads;
  String? filePath;
  String? fileName;
  String? bucketName;
  String? contentType;
  int? length;
  int? trxId;
  String? flag;
  String? remark;
  int? id;
  DateTime? createdDate;
  String? createdDateFormat;
  String? createdBy;
  DateTime? updateDate;
  dynamic updateBy;
  String? fileUrl; 
  int? qtyInOut;
  DateTime? date;
  String? status;
  int? warehouseItemId;
  String? aktor;
  int? code;
  bool? isSuccess;
  dynamic errorMsg;
  String? d;

  TransactionParamModel({
    required this.limit,
    required this.offset,
    this.itemName,
    this.itemCategory,
    this.qty,
    this.minQty,
    this.warehouseName,
    this.address,
    this.description,
    this.idFileUploads,
    this.filePath,
    this.fileName,
    this.bucketName,
    this.contentType,
    this.length,
    this.trxId,
    this.flag,
    this.remark,
    this.id,
    this.createdDate,
    this.createdDateFormat,
    this.createdBy,
    this.updateDate,
    this.updateBy,
    this.fileUrl,
    this.qtyInOut,
    this.date,
    this.status,
    this.warehouseItemId,
    this.aktor,
    this.code,
    this.isSuccess,
    this.errorMsg,
    this.d,
  });

  factory TransactionParamModel.fromJson(Map<String, dynamic> json) => TransactionParamModel(
    limit: json["limit"] ?? 0,
    offset: json["offset"] ?? 0,
    itemName: json["itemName"],
    itemCategory: json["itemCategory"],
    qty: json["qty"] ?? 0,
    minQty: json["minQty"] ?? 0,
    warehouseName: json["warehouseName"],
    address: json["address"],
    description: json["description"],
    idFileUploads: json["idFileUploads"] ?? 0,
    filePath: json["filePath"],
    fileName: json["fileName"],
    bucketName: json["bucketName"],
    contentType: json["contentType"],
    length: json["length"] ?? 0,
    trxId: json["trxId"] ?? 0,
    flag: json["flag"],
    remark: json["remark"],
    id: json["id"] ?? 0,
    createdDate: json["createdDate"] != null ? DateTime.parse(json["createdDate"]) : null,
    createdDateFormat: json["createdDateFormat"],
    createdBy: json["createdBy"],
    updateDate: json["updateDate"] != null ? DateTime.parse(json["updateDate"]) : null,
    updateBy: json["updateBy"],
    fileUrl: json["fileUrl"], 
    qtyInOut: json["qtyInOut"] ?? 0,
    date: json["date"] != null ? DateTime.parse(json["date"]) : null,
    status: json["status"],
    warehouseItemId: json["warehouseItemId"],
    aktor: json["aktor"],
    d: json["d"],
  );

  Map<String, dynamic> toJson() => {
    "limit": limit,
    "offset": offset,
    "itemName": itemName,
    "itemCategory": itemCategory,
    "qty": qty,
    "minQty": minQty,
    "warehouseName": warehouseName,
    "address": address,
    "description": description,
    "idFileUploads": idFileUploads,
    "filePath": filePath,
    "fileName": fileName,
    "bucketName": bucketName,
    "contentType": contentType,
    "length": length,
    "trxId": trxId,
    "flag": flag,
    "remark": remark,
    "id": id,
    "createdDate": createdDate?.toIso8601String(),
    "createdDateFormat": createdDateFormat,
    "createdBy": createdBy,
    "updateDate": updateDate?.toIso8601String(),
    "updateBy": updateBy,
    "fileUrl": fileUrl, 
    "qtyInOut": qtyInOut,
    "date": date?.toIso8601String(),
    "status": status,
    "warehouseItemId": warehouseItemId,
    "aktor": aktor,
    "d": d,
  };

  TransactionParamModel copyWith({
    int? limit,
    int? offset,
    String? itemName,
    String? itemCategory,
    int? qty,
    int? minQty,
    String? warehouseName,
    int? idFileUploads,
    String? filePath,
    String? fileName,
    String? bucketName,
    String? contentType,
    int? length,
    int? trxId,
    String? flag,
    String? remark,
    int? id,
    DateTime? createdDate,
    String? createdDateFormat,
    String? createdBy,
    DateTime? updateDate,
    dynamic updateBy,
    String? fileUrl,
    int? qtyInOut,
    DateTime? date,
    String? status,
    int? warehouseItemId,
    String? aktor,
    String? d,
  }) {
    return TransactionParamModel(
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      itemName: itemName ?? this.itemName,
      itemCategory: itemCategory ?? this.itemCategory,
      qty: qty ?? this.qty,
      minQty: minQty ?? this.minQty,
      warehouseName: warehouseName ?? this.warehouseName,
      idFileUploads: idFileUploads ?? this.idFileUploads,
      filePath: filePath ?? this.filePath,
      fileName: fileName ?? this.fileName,
      bucketName: bucketName ?? this.bucketName,
      contentType: contentType ?? this.contentType,
      length: length ?? this.length,
      trxId: trxId ?? this.trxId,
      flag: flag ?? this.flag,
      remark: remark ?? this.remark,
      id: id ?? this.id,
      createdDate: createdDate ?? this.createdDate,
      createdDateFormat: createdDateFormat ?? this.createdDateFormat,
      createdBy: createdBy ?? this.createdBy,
      updateDate: updateDate ?? this.updateDate,
      updateBy: updateBy ?? this.updateBy,
      fileUrl: fileUrl ?? this.fileUrl,
      qtyInOut: qtyInOut ?? this.qtyInOut,
      date: date ?? this.date,
      status: status ?? this.status,
      warehouseItemId: warehouseItemId ?? this.warehouseItemId,
      aktor: aktor ?? this.aktor,
      d: d ?? this.d,
    );
  }
}
