// To parse this JSON data, do
//
//     final getSubKategoriBarangModel = getSubKategoriBarangModelFromJson(jsonString);

import 'dart:convert';

class GetSubKategoriBarangModel {
  GetSubKategoriBarangModel({
    this.status,
    this.data,
    this.message,
  });

  bool status;
  List<Datum> data;
  String message;

  factory GetSubKategoriBarangModel.fromRawJson(String str) => GetSubKategoriBarangModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetSubKategoriBarangModel.fromJson(Map<String, dynamic> json) => GetSubKategoriBarangModel(
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
    this.idSubkategori,
    this.idKategori,
    this.namaSubkategori,
  });

  String idSubkategori;
  String idKategori;
  String namaSubkategori;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idSubkategori: json["id_subkategori"],
    idKategori: json["id_kategori"],
    namaSubkategori: json["nama_subkategori"],
  );

  Map<String, dynamic> toJson() => {
    "id_subkategori": idSubkategori,
    "id_kategori": idKategori,
    "nama_subkategori": namaSubkategori,
  };
}
