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

  bool? status;
  List<KategoriDatum>? data;
  String? message;

  factory GetKategoriBarangModel.fromRawJson(String str) =>
      GetKategoriBarangModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetKategoriBarangModel.fromJson(Map<String, dynamic> json) =>
      GetKategoriBarangModel(
        status: json["status"],
        data: List<KategoriDatum>.from(
            json["data"].map((x) => KategoriDatum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class KategoriDatum {
  KategoriDatum({
    this.idKategori,
    this.namaKategori,
  });

  String? idKategori;
  String? namaKategori;

  factory KategoriDatum.fromRawJson(String str) =>
      KategoriDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory KategoriDatum.fromJson(Map<String, dynamic> json) => KategoriDatum(
        idKategori: json["id_kategori"],
        namaKategori: json["nama_kategori"],
      );

  Map<String, dynamic> toJson() => {
        "id_kategori": idKategori,
        "nama_kategori": namaKategori,
      };
}
