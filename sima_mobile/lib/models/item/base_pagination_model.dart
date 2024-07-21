import 'dart:convert';

import 'package:sima/models/item/item_pagination_model.dart';

ItemPaginationResponseModels itemPaginationModelsFromJson(String str) => ItemPaginationResponseModels.fromJson(json.decode(str));

String itemPaginationModelsToJson(ItemPaginationResponseModels data) => json.encode(data.toJson());

class ItemPaginationResponseModels {
    List<ItemPaginationModel>data;
    int offset;
    bool isNext;

    ItemPaginationResponseModels({
        required this.data,
        required this.offset,
        required this.isNext,
    });

    factory ItemPaginationResponseModels.fromJson(Map<String, dynamic> json) => ItemPaginationResponseModels(
        data: List<ItemPaginationModel>.from(json["data"].map((x) => ItemPaginationModel.fromJson(x))),
        offset: json["offset"],
        isNext: json["isNext"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "offset": offset,
        "isNext": isNext,
    };
}