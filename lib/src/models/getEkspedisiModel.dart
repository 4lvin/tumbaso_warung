// To parse this JSON data, do
//
//     final getEkspedisiModel = getEkspedisiModelFromJson(jsonString);

import 'dart:convert';

class GetEkspedisiModel {
  GetEkspedisiModel({
    this.status,
    this.data,
    this.message,
  });

  bool status;
  List<Datum> data;
  String message;

  factory GetEkspedisiModel.fromRawJson(String str) => GetEkspedisiModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetEkspedisiModel.fromJson(Map<String, dynamic> json) => GetEkspedisiModel(
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
    this.idKurir,
    this.kodeKurir,
    this.namaKurir,
  });

  String idKurir;
  String kodeKurir;
  String namaKurir;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idKurir: json["id_kurir"],
    kodeKurir: json["kode_kurir"],
    namaKurir: json["nama_kurir"],
  );

  Map<String, dynamic> toJson() => {
    "id_kurir": idKurir,
    "kode_kurir": kodeKurir,
    "nama_kurir": namaKurir,
  };
}
