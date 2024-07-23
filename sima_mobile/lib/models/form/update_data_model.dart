import 'dart:io';

class UpdateDataModel {
  String name;
  String code;
  String? category;
  String description;
  String createdBy;
  File? fileUploads; 

  UpdateDataModel({
    required this.name,
    required this.code,
    this.category,
    required this.description,
    required this.createdBy,
    this.fileUploads,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'category': category,
      'description': description,
      'createdBy': createdBy,
      'fileUploads': fileUploads,
    };
  }
}
