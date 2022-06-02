// To parse this JSON data, do
//
//     final resLengkapiProfilModel = resLengkapiProfilModelFromJson(jsonString);

import 'dart:convert';

class ResLengkapiProfilModel {
  ResLengkapiProfilModel({
    this.status,
    this.message,
  });

  bool? status;
  String? message;

  factory ResLengkapiProfilModel.fromRawJson(String str) => ResLengkapiProfilModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResLengkapiProfilModel.fromJson(Map<String, dynamic> json) => ResLengkapiProfilModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
