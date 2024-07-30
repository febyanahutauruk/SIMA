import 'dart:convert';
import 'package:sima/models/transaction/transaction_pagination_model.dart';

TransactionPaginationResponseModel transactionPaginationModelFromJson(String str) => 
    TransactionPaginationResponseModel.fromJson(json.decode(str));
String transactionPaginationModelToJson(TransactionPaginationResponseModel data) => 
    json.encode(data.toJson());

class TransactionPaginationResponseModel {
  List<TransactionPaginationModel> data;
  int offset;
  bool isNext;

  TransactionPaginationResponseModel({
    required this.data,
    required this.offset,
    required this.isNext,
  });

  factory TransactionPaginationResponseModel.fromJson(Map<String, dynamic> json) => 
      TransactionPaginationResponseModel(
        data: List<TransactionPaginationModel>.from(json["data"].map((x) => TransactionPaginationModel.fromJson(x))),
        offset: json["offset"],
        isNext: json["isNext"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "offset": offset,
        "isNext": isNext,
      };
}
