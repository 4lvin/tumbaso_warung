// To parse this JSON data, do
//
//     final getStatusModel = getStatusModelFromJson(jsonString);

import 'dart:convert';

class GetStatusModel {
  GetStatusModel({
    this.status,
    this.data,
    this.message,
  });

  bool status;
  List<Datum> data;
  String message;

  factory GetStatusModel.fromRawJson(String str) => GetStatusModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetStatusModel.fromJson(Map<String, dynamic> json) => GetStatusModel(
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
    this.idPenjual,
    this.email,
    this.nama,
    this.alamat,
    this.longitude,
    this.latitude,
    this.aktif,
  });

  String idPenjual;
  String email;
  String nama;
  String alamat;
  String longitude;
  String latitude;
  String aktif;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idPenjual: json["id_penjual"],
    email: json["email"],
    nama: json["nama"],
    alamat: json["alamat"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    aktif: json["aktif"],
  );

  Map<String, dynamic> toJson() => {
    "id_penjual": idPenjual,
    "email": email,
    "nama": nama,
    "alamat": alamat,
    "longitude": longitude,
    "latitude": latitude,
    "aktif": aktif,
  };
}
