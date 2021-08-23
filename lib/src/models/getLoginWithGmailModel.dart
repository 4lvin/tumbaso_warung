// To parse this JSON data, do
//
//     final getLoginWithGmailModel = getLoginWithGmailModelFromJson(jsonString);

import 'dart:convert';

class GetLoginWithGmailModel {
  GetLoginWithGmailModel({
    this.status,
    this.data,
    this.message,
  });

  bool status;
  Data data;
  String message;

  factory GetLoginWithGmailModel.fromRawJson(String str) => GetLoginWithGmailModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetLoginWithGmailModel.fromJson(Map<String, dynamic> json) => GetLoginWithGmailModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
    "message": message,
  };
}

class Data {
  Data({
    this.idToken,
    this.key,
    this.email,
    this.username,
    this.nama,
    this.telepone,
    this.longitude,
    this.latitude,
  });

  String idToken;
  Key key;
  String email;
  String username;
  String nama;
  String telepone;
  String longitude;
  String latitude;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    idToken: json["id_token"],
    key: Key.fromJson(json["key"]),
    email: json["email"],
    username: json["username"],
    nama: json["nama"],
    telepone: json["telepone"],
    longitude: json["longitude"],
    latitude: json["latitude"],
  );

  Map<String, dynamic> toJson() => {
    "id_token": idToken,
    "key": key.toJson(),
    "email": email,
    "username": username,
    "nama": nama,
    "telepone": telepone,
    "longitude": longitude,
    "latitude": latitude,
  };
}

class Key {
  Key({
    this.idPenjual,
    this.idPenjualMakmur,
  });

  String idPenjual;
  String idPenjualMakmur;

  factory Key.fromRawJson(String str) => Key.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Key.fromJson(Map<String, dynamic> json) => Key(
    idPenjual: json["id_penjual"],
    idPenjualMakmur: json["id_penjual_makmur"],
  );

  Map<String, dynamic> toJson() => {
    "id_penjual": idPenjual,
    "id_penjual_makmur": idPenjualMakmur,
  };
}
