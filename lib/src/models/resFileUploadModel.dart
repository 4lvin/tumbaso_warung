// To parse this JSON data, do
//
//     final fileUploadModel = fileUploadModelFromJson(jsonString);

import 'dart:convert';

FileUploadModel fileUploadModelFromJson(String str) =>
    FileUploadModel.fromJson(json.decode(str));

String fileUploadModelToJson(FileUploadModel data) =>
    json.encode(data.toJson());

class FileUploadModel {
  FileUploadModel({
    this.status,
    this.foto,
  });

  bool status;
  String foto;

  factory FileUploadModel.fromJson(Map<String, dynamic> json) =>
      FileUploadModel(
        status: json["status"],
        foto: json["foto"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "foto": foto,
      };
}
