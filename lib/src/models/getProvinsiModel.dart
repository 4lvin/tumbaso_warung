// To parse this JSON data, do
//
//     final getProvinsiModel = getProvinsiModelFromJson(jsonString);

import 'dart:convert';

class GetProvinsiModel {
  GetProvinsiModel({
    this.status,
    this.data,
    this.message,
  });

  bool status;
  List<ResultProv> data;
  String message;

  factory GetProvinsiModel.fromRawJson(String str) => GetProvinsiModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetProvinsiModel.fromJson(Map<String, dynamic> json) => GetProvinsiModel(
    status: json["status"],
    data: List<ResultProv>.from(json["data"].map((x) => ResultProv.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class ResultProv {
  ResultProv({
    this.idProvinsi,
    this.namaProvinsi,
  });

  String idProvinsi;
  String namaProvinsi;

  factory ResultProv.fromRawJson(String str) => ResultProv.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResultProv.fromJson(Map<String, dynamic> json) => ResultProv(
    idProvinsi: json["id_provinsi"],
    namaProvinsi: json["nama_provinsi"],
  );

  Map<String, dynamic> toJson() => {
    "id_provinsi": idProvinsi,
    "nama_provinsi": namaProvinsi,
  };
}
