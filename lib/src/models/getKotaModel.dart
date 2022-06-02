// To parse this JSON data, do
//
//     final getKotaModel = getKotaModelFromJson(jsonString);

import 'dart:convert';

class GetKotaModel {
  GetKotaModel({
    this.status,
    this.data,
    this.message,
  });

  bool? status;
  List<ResultKota>? data;
  String? message;

  factory GetKotaModel.fromRawJson(String str) => GetKotaModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetKotaModel.fromJson(Map<String, dynamic> json) => GetKotaModel(
    status: json["status"],
    data: List<ResultKota>.from(json["data"].map((x) => ResultKota.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class ResultKota {
  ResultKota({
    this.idKabupaten,
    this.provinsiId,
    this.namaKabupaten,
  });

  String? idKabupaten;
  String? provinsiId;
  String? namaKabupaten;

  factory ResultKota.fromRawJson(String str) => ResultKota.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResultKota.fromJson(Map<String, dynamic> json) => ResultKota(
    idKabupaten: json["id_kabupaten"],
    provinsiId: json["provinsi_id"],
    namaKabupaten: json["nama_kabupaten"],
  );

  Map<String, dynamic> toJson() => {
    "id_kabupaten": idKabupaten,
    "provinsi_id": provinsiId,
    "nama_kabupaten": namaKabupaten,
  };
}
