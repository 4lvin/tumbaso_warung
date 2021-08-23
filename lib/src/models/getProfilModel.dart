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
    this.idReseller,
    this.email,
    this.nama,
    this.pilihanKurir,
    this.status,
    this.provinsiId,
    this.kotaId,
    this.kecamatanId,
    this.alamatLengkap,
    this.telepone,
  });

  String idReseller;
  String email;
  String nama;
  String pilihanKurir;
  String status;
  String provinsiId;
  String kotaId;
  String kecamatanId;
  String alamatLengkap;
  String telepone;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idReseller: json["id_reseller"],
    email: json["email"],
    nama: json["nama"],
    pilihanKurir: json["pilihan_kurir"],
    status: json["status"],
    provinsiId: json["provinsi_id"],
    kotaId: json["kota_id"],
    kecamatanId: json["kecamatan_id"],
    alamatLengkap: json["alamat_lengkap"],
    telepone: json["telepone"],
  );

  Map<String, dynamic> toJson() => {
    "id_reseller": idReseller,
    "email": email,
    "nama": nama,
    "pilihan_kurir": pilihanKurir,
    "status": status,
    "provinsi_id": provinsiId,
    "kota_id": kotaId,
    "kecamatan_id": kecamatanId,
    "alamat_lengkap": alamatLengkap,
    "telepone": telepone,
  };
}
