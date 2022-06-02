// To parse this JSON data, do
//
//     final cekResiModel = cekResiModelFromMap(jsonString);

import 'dart:convert';

class CekResiModel {
  CekResiModel({
    this.status,
    this.data,
    this.message,
  });

  bool? status;
  List<Datum>? data;
  String? message;

  factory CekResiModel.fromJson(String str) =>
      CekResiModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CekResiModel.fromMap(Map<String, dynamic> json) => CekResiModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
        "message": message,
      };
}

class Datum {
  Datum({
    this.status,
    this.tanggal,
    this.destinasi,
  });

  String? status;
  DateTime? tanggal;
  String? destinasi;

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        status: json["status"],
        tanggal: DateTime.parse(json["tanggal"]),
        destinasi: json["Destinasi"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "tanggal": tanggal!.toIso8601String(),
        "Destinasi": destinasi,
      };
}
