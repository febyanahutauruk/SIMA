import 'dart:convert';

import 'package:sima/models/history/history_pagination_model.dart';

HistoryPaginationResponseModels historyPaginationModelsFromJson(String str) => HistoryPaginationResponseModels.fromJson(json.decode(str));

String historyPaginationModelsToJson(HistoryPaginationResponseModels data) => json.encode(data.toJson());

class HistoryPaginationResponseModels {
    List<HistoryPaginationModel>data;
    int offset;
    bool isNext;

    HistoryPaginationResponseModels({
        required this.data,
        required this.offset,
        required this.isNext,
    });

    factory HistoryPaginationResponseModels.fromJson(Map<String, dynamic> json) => HistoryPaginationResponseModels(
        data: List<HistoryPaginationModel>.from(json["data"].map((x) => HistoryPaginationModel.fromJson(x))),
        offset: json["offset"],
        isNext: json["isNext"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "offset": offset,
        "isNext": isNext,
    };
}

