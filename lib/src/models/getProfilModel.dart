// To parse this JSON data, do
//
//     final getProfilModel = getProfilModelFromJson(jsonString);

import 'dart:convert';

class GetProfilModel {
  GetProfilModel({
    this.status,
    this.data,
    this.message,
  });

  bool status;
  List<Datum> data;
  String message;

  factory GetProfilModel.fromRawJson(String str) => GetProfilModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetProfilModel.fromJson(Map<String, dynamic> json) => GetProfilModel(
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
    this.idPenjualMakmur,
    this.email,
    this.nama,
    this.username,
    this.alamat,
    this.namaToko,
    this.latitude,
    this.longitude,
    this.telepone,
    this.provinsiId,
    this.kotaId,
    this.kecamatanId,
    this.pilihanKurir,
  });

  String idPenjual;
  String idPenjualMakmur;
  String email;
  String nama;
  String username;
  String alamat;
  String namaToko;
  String latitude;
  String longitude;
  String telepone;
  String provinsiId;
  String kotaId;
  String kecamatanId;
  String pilihanKurir;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idPenjual: json["id_penjual"],
    idPenjualMakmur: json["id_penjual_makmur"],
    email: json["email"],
    nama: json["nama"],
    username: json["username"],
    alamat: json["alamat"],
    namaToko: json["nama_toko"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    telepone: json["telepone"],
    provinsiId: json["provinsi_id"],
    kotaId: json["kota_id"],
    kecamatanId: json["kecamatan_id"],
    pilihanKurir: json["pilihan_kurir"],
  );

  Map<String, dynamic> toJson() => {
    "id_penjual": idPenjual,
    "id_penjual_makmur": idPenjualMakmur,
    "email": email,
    "nama": nama,
    "username": username,
    "alamat": alamat,
    "nama_toko": namaToko,
    "latitude": latitude,
    "longitude": longitude,
    "telepone": telepone,
    "provinsi_id": provinsiId,
    "kota_id": kotaId,
    "kecamatan_id": kecamatanId,
    "pilihan_kurir": pilihanKurir,
  };
}
