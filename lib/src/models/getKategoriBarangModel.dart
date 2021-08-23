// To parse this JSON data, do
//
//     final getKategoriBarangModel = getKategoriBarangModelFromJson(jsonString);

import 'dart:convert';

class GetKategoriBarangModel {
  GetKategoriBarangModel({
    this.status,
    this.data,
    this.message,
  });

  bool status;
  List<Datum> data;
  String message;

  factory GetKategoriBarangModel.fromRawJson(String str) => GetKategoriBarangModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetKategoriBarangModel.fromJson(Map<String, dynamic> json) => GetKategoriBarangModel(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class Datum {
  Datum({
    this.idKategori,
    this.namaKategori,
  });

  String idKategori;
  String namaKategori;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idKategori: json["id_kategori"],
    namaKategori: json["nama_kategori"],
  );

  Map<String, dynamic> toJson() => {
    "id_kategori": idKategori,
    "nama_kategori": namaKategori,
  };
}
