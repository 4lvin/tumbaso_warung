// To parse this JSON data, do
//
//     final resLoginModel = resLoginModelFromJson(jsonString);

import 'dart:convert';

class ResLoginModel {
  ResLoginModel({
    this.status,
    this.data,
    this.message,
  });

  bool? status;
  Data? data;
  String? message;

  factory ResLoginModel.fromRawJson(String str) =>
      ResLoginModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResLoginModel.fromJson(Map<String, dynamic> json) => ResLoginModel(
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
    this.idToken,
    this.idPenjual,
    this.email,
    this.namaLengkap,
    this.telepone,
    this.longitude,
    this.latitude,
  });

  String? idToken;
  String? idPenjual;
  String? email;
  String? namaLengkap;
  String? telepone;
  String? longitude;
  String? latitude;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idToken: json["id_token"],
        idPenjual: json["id_penjual"],
        email: json["email"],
        namaLengkap: json["nama_lengkap"],
        telepone: json["telepone"],
        longitude: json["longitude"],
        latitude: json["latitude"],
      );

  Map<String, dynamic> toJson() => {
        "id_token": idToken,
        "id_penjual": idPenjual,
        "email": email,
        "nama_lengkap": namaLengkap,
        "telepone": telepone,
        "longitude": longitude,
        "latitude": latitude,
      };
}
