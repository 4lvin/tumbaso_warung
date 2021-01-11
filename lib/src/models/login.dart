// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    this.status,
    this.data,
    this.message,
  });

  bool status;
  Data data;
  String message;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
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
    this.username,
    this.namaLengkap,
    this.telepone,
    this.longitude,
    this.latitude,
  });

  String idToken;
  String username;
  String namaLengkap;
  String telepone;
  String longitude;
  String latitude;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    idToken: json["id_token"],
    username: json["username"],
    namaLengkap: json["nama_lengkap"],
    telepone: json["telepone"],
    longitude: json["longitude"],
    latitude: json["latitude"],
  );

  Map<String, dynamic> toJson() => {
    "id_token": idToken,
    "username": username,
    "nama_lengkap": namaLengkap,
    "telepone": telepone,
    "longitude": longitude,
    "latitude": latitude,
  };
}
