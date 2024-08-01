class TransactionPaginationModel {
  String itemName;
  String itemCategory;
  int qty;
  int minQty;
  String warehouseName;
  String address;
  String description;
  int idFileUploads;
  String filePath;
  String fileName;
  String bucketName;
  String contentType;
  int length;
  int trxId;
  String flag;
  String remark;
  int? id;
  DateTime createdDate;
  String createdDateFormat;
  String createdBy;
  DateTime updateDate;
  dynamic updateBy;
  String fileUrl;
  int qtyInOut;
  String status;
  int warehouseItemId;
  String aktor;
  int code;
  bool isSuccess;
  dynamic errorMsg;
  bool? isStream;

  TransactionPaginationModel({
    required this.itemName,
    required this.itemCategory,
    required this.qty,
    required this.minQty,
    required this.warehouseName,
    required this.address,
    required this.description,
    required this.idFileUploads,
    required this.filePath,
    required this.fileName,
    required this.bucketName,
    required this.contentType,
    required this.length,
    required this.trxId,
    required this.flag,
    required this.remark,
    required this.id,
    required this.createdDate,
    required this.createdDateFormat,
    required this.createdBy,
    required this.updateDate,
    required this.updateBy,
    required this.fileUrl,
    required this.qtyInOut,
    required this.status,
    required this.warehouseItemId,
    required this.aktor,
    required this.code,
    required this.isSuccess,
    this.errorMsg,
    this.isStream,
  });

  factory TransactionPaginationModel.fromJson(Map<String, dynamic> json) {
  return TransactionPaginationModel(
    itemName: json["itemName"] ?? '',
    itemCategory: json["itemCategory"] ?? '',
    qty: json["qty"] ?? 0,
    minQty: json["minQty"] ?? 0,
    warehouseName: json["warehouseName"] ?? '',
    address: json["address"],
    description: json["description"],
    idFileUploads: json["idFileUploads"] ?? 0,
    filePath: json["filePath"] ?? '',
    fileName: json["fileName"] ?? '',
    bucketName: json["bucketName"] ?? '',
    contentType: json["contentType"] ?? '',
    length: json["length"] ?? 0,
    trxId: json["trxId"] ?? 0,
    flag: json["flag"] ?? '',
    remark: json["remark"] ?? '',
    id: json["id"] ?? 0,
    createdDate: DateTime.parse(json["createdDate"] ?? DateTime.now().toIso8601String()),
    createdDateFormat: json["createdDateFormat"] ?? '',
    createdBy: json["createdBy"] ?? '',
    updateDate: DateTime.parse(json["updateDate"] ?? DateTime.now().toIso8601String()),
    updateBy: json["updateBy"] ?? 0,
    fileUrl: json["fileUrl"] ?? '',
    qtyInOut: json["qtyInOut"] ?? 0,
    status: json["status"] ?? '',
    warehouseItemId: json["warehouseItemId"] ?? 0,
    aktor: json["aktor"] ?? '',
    code: json["code"] ?? 0,
    isSuccess: json["isSuccess"] ?? false,
    errorMsg: json["errorMsg"],
  );
}


  Map<String, dynamic> toJson() => {
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
    "createdDate": createdDate.toIso8601String(),
    "createdDateFormat": createdDateFormat,
    "createdBy": createdBy,
    "updateDate": updateDate.toIso8601String(),
    "updateBy": updateBy,
    "fileUrl": fileUrl,
    "qtyInOut": qtyInOut,
    "status": status,
    "warehouseItemId": warehouseItemId,
    "aktor": aktor,
    "code": code,
    "isSuccess": isSuccess,
    "errorMsg": errorMsg,
  };
}
