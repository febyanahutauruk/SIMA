// To parse this JSON data, do
//
//     final itemPaginationModels = itemPaginationModelsFromJson(jsonString);


import 'package:sima/models/form/update_data_model.dart';


class ItemPaginationModel {
    String code;
    String name;
    String description;
    // dynamic image;
    String categoryName;
    int id;
    // DateTime createdDate;
    // String createdDateFormat;
    String createdBy;
    // DateTime updateDate;
    // String? updateBy;

    ItemPaginationModel({
        required this.code,
        required this.name,
        required this.description,
        // required this.image,
        required this.categoryName,
        required this.id, 
        // required this.createdDate,
        // required this.createdDateFormat,
        required this.createdBy,
        // required this.updateDate,
        // required this.updateBy,
    });

    factory ItemPaginationModel.fromJson(Map<String, dynamic> json) => ItemPaginationModel(
        code: json["code"] ??"",
        name: json["name"] ??"",
        description: json["description"] ??"",
        // image: json["image"],
        categoryName: json["categoryName"] ??"",
        id: json["id"] ??"",
        // createdDate: DateTime.parse(json["createdDate"]),
        // createdDateFormat: json["createdDateFormat"],
        createdBy: json["createdBy"],
        // updateDate: DateTime.parse(json["updateDate"]),
        // updateBy: json["updateBy"],
    );


    Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "description": description,
        // "image": image,
        "categoryName": categoryName,
        "id": id,
        // "createdDate": createdDate.toIso8601String(),
        // "createdDateFormat": createdDateFormat,
        "createdBy": createdBy,
        // "updateDate": updateDate.toIso8601String(),
        // "updateBy": updateBy,
    };
}
