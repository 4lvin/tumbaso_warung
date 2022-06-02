// To parse this JSON data, do
//
//     final resUpdateStatusProdukModel = resUpdateStatusProdukModelFromJson(jsonString);

import 'dart:convert';

class ResUpdateStatusProdukModel {
  ResUpdateStatusProdukModel({
    this.status,
    this.data,
    this.message,
  });

  bool? status;
  Data? data;
  String? message;

  factory ResUpdateStatusProdukModel.fromRawJson(String str) => ResUpdateStatusProdukModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResUpdateStatusProdukModel.fromJson(Map<String, dynamic> json) => ResUpdateStatusProdukModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data!.toJson(),
    "message": message,
  };
}

class Data {
  Data({
    this.username,
  });

  String? username;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
  };
}
