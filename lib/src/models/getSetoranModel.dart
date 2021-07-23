// To parse this JSON data, do
//
//     final getSetoranModel = getSetoranModelFromJson(jsonString);

import 'dart:convert';

GetSetoranModel getSetoranModelFromJson(String str) => GetSetoranModel.fromJson(json.decode(str));

String getSetoranModelToJson(GetSetoranModel data) => json.encode(data.toJson());

class GetSetoranModel {
    GetSetoranModel({
        this.status,
        this.data,
        this.message,
    });

    bool status;
    List<Datum> data;
    String message;

    factory GetSetoranModel.fromJson(Map<String, dynamic> json) => GetSetoranModel(
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
        this.penjualId,
        this.setorPenjual,
        this.tunggakanSetor,
        this.tanggal,
    });

    String penjualId;
    int setorPenjual;
    int tunggakanSetor;
    DateTime tanggal;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        penjualId: json["penjual_id"],
        setorPenjual: json["setor_penjual"],
        tunggakanSetor: json["tunggakan_setor"],
        tanggal: DateTime.parse(json["tanggal"]),
    );

    Map<String, dynamic> toJson() => {
        "penjual_id": penjualId,
        "setor_penjual": setorPenjual,
        "tunggakan_setor": tunggakanSetor,
        "tanggal": "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
    };
}
