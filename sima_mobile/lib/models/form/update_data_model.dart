import 'dart:io';

class UpdateDataModel {
  int? id;
  String name;
  String code;
  String? description;
  int? category;
  File? fileUploads;
  String createdBy;

  UpdateDataModel({
    this.id,
    required this.name,
    required this.code,
    this.description,
    this.category,
    this.fileUploads,
    required this.createdBy,
  });

  factory UpdateDataModel.fromJson(Map<String, dynamic> json) => UpdateDataModel(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    description: json["description"],
    category: json["category"],
    createdBy: json["createdBy"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "description": description,
    "category": category,
    "createdBy": createdBy,
  };
}