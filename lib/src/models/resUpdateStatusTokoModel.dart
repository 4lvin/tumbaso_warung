// To parse this JSON data, do
//
//     final resUpdateStatusTokoModel = resUpdateStatusTokoModelFromJson(jsonString);

import 'dart:convert';

class ResUpdateStatusTokoModel {
  ResUpdateStatusTokoModel({
    this.status,
    this.data,
    this.message,
  });

  bool status;
  Data data;
  String message;

  factory ResUpdateStatusTokoModel.fromRawJson(String str) => ResUpdateStatusTokoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResUpdateStatusTokoModel.fromJson(Map<String, dynamic> json) => ResUpdateStatusTokoModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
    "message": message,
  };
}

class Data {
  Data({
    this.username,
  });

  String username;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
  };
}
