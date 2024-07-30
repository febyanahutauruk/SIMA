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

  TransactionParamModel({
    required this.limit,
    required this.offset,
    this.itemName,
    this.itemCategory,
    this.qty,
    this.minQty,
    this.warehouseName,
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
  });

  factory TransactionParamModel.fromJson(Map<String, dynamic> json) => TransactionParamModel(
    limit: json["limit"] ?? '',
    offset: json["offset"] ?? '',
    itemName: json["itemName"],
    itemCategory: json["itemCategory"],
    qty: json["qty"] ?? '',
    minQty: json["minQty"]  ?? '',
    warehouseName: json["warehouseName"],
    idFileUploads: json["idFileUploads"] ?? '',
    filePath: json["filePath"],
    fileName: json["fileName"],
    bucketName: json["bucketName"],
    contentType: json["contentType"],
    length: json["length"] ?? '',
    trxId: json["trxId"] ?? '',
    flag: json["flag"],
    remark: json["remark"],
    id: json["id"] ?? '',
    createdDate: json["createdDate"] != null ? DateTime.parse(json["createdDate"]) : null,
    createdDateFormat: json["createdDateFormat"],
    createdBy: json["createdBy"],
    updateDate: json["updateDate"] != null ? DateTime.parse(json["updateDate"]) : null,
    updateBy: json["updateBy"],
    fileUrl: json["fileUrl"],
    qtyInOut: json["qtyInOut"] ?? '',
    date: json["date"] != null ? DateTime.parse(json["date"]) : null,
    status: json["status"],
    warehouseItemId: json["warehouseItemId"] ,
    aktor: json["aktor"],
  );

  Map<String, dynamic> toJson() => {
    "limit": limit,
    "offset": offset,
    "itemName": itemName,
    "itemCategory": itemCategory,
    "qty": qty,
    "minQty": minQty,
    "warehouseName": warehouseName,
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
      fileUrl: this.fileUrl,
      qtyInOut: this.qtyInOut,
      date: this.date,
      status: this.status,
      warehouseItemId: this.warehouseItemId,
      aktor: this.aktor,
    );
  }
}
