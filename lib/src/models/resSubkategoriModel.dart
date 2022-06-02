// To parse this JSON data, do
//
//     final resSubkategoriModel = resSubkategoriModelFromJson(jsonString);

import 'dart:convert';

ResSubkategoriModel resSubkategoriModelFromJson(String str) =>
    ResSubkategoriModel.fromJson(json.decode(str));

String resSubkategoriModelToJson(ResSubkategoriModel data) =>
    json.encode(data.toJson());

class ResSubkategoriModel {
  ResSubkategoriModel({
    this.status,
    this.data,
    this.message,
  });

  bool? status;
  List<Datum>? data;
  String? message;

  factory ResSubkategoriModel.fromJson(Map<String, dynamic> json) =>
      ResSubkategoriModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  Datum({
    this.idSubkategori,
    this.namaSubkategori,
  });

  String? idSubkategori;
  String? namaSubkategori;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idSubkategori: json["id_subkategori"],
        namaSubkategori: json["nama_subkategori"],
      );

  Map<String, dynamic> toJson() => {
        "id_subkategori": idSubkategori,
        "nama_subkategori": namaSubkategori,
      };
}
