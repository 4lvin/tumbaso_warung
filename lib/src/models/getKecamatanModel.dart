// To parse this JSON data, do
//
//     final getKecamatanModel = getKecamatanModelFromJson(jsonString);

import 'dart:convert';

class GetKecamatanModel {
  GetKecamatanModel({
    this.status,
    this.data,
    this.message,
  });

  bool? status;
  List<ResultKec>? data;
  String? message;

  factory GetKecamatanModel.fromRawJson(String str) => GetKecamatanModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetKecamatanModel.fromJson(Map<String, dynamic> json) => GetKecamatanModel(
    status: json["status"],
    data: List<ResultKec>.from(json["data"].map((x) => ResultKec.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class ResultKec {
  ResultKec({
    this.idKecamatan,
    this.kabupatenId,
    this.namaKecamatan,
  });

  String? idKecamatan;
  String? kabupatenId;
  String? namaKecamatan;

  factory ResultKec.fromRawJson(String str) => ResultKec.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResultKec.fromJson(Map<String, dynamic> json) => ResultKec(
    idKecamatan: json["id_kecamatan"],
    kabupatenId: json["kabupaten_id"],
    namaKecamatan: json["nama_kecamatan"],
  );

  Map<String, dynamic> toJson() => {
    "id_kecamatan": idKecamatan,
    "kabupaten_id": kabupatenId,
    "nama_kecamatan": namaKecamatan,
  };
}
