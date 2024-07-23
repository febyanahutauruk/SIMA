import 'dart:convert';
import 'dart:io';

class ItemFormModel {
  String name;
  String code;
  String? description;
  String? category; 
  File? fileUploads;
  String createdBy;

  ItemFormModel({
    required this.name,
    required this.code,
    this.description,
    this.category,
    this.fileUploads,
    required this.createdBy,
  });

  factory ItemFormModel.fromJson(Map<String, dynamic> json) => ItemFormModel(
    name: json["name"],
    code: json["code"],
    description: json["description"],
    category: json["category"],
    fileUploads: json["fileUploads"],
    createdBy: json["createdBy"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "code": code,
    "description": description,
    "category": category,
    "fileUploads": fileUploads,
    "createdBy": createdBy,
  };
}
