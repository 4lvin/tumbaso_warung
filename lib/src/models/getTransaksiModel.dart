// To parse this JSON data, do
//
//     final getTransaksiModel = getTransaksiModelFromJson(jsonString);

import 'dart:convert';

GetTransaksiModel getTransaksiModelFromJson(String str) =>
    GetTransaksiModel.fromJson(json.decode(str));

String getTransaksiModelToJson(GetTransaksiModel data) =>
    json.encode(data.toJson());

class GetTransaksiModel {
  GetTransaksiModel({
    this.status,
    this.data,
    this.message,
  });

  bool? status;
  List<Datum>? data;
  String? message;

  factory GetTransaksiModel.fromJson(Map<String, dynamic> json) =>
      GetTransaksiModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  Datum({
    this.idPemesanan,
    this.kodeTransaksi,
    this.totalHarga,
    this.totalOngkir,
    this.longitude,
    this.latitude,
    this.status,
    this.produk,
    this.detailPengiriman,
    this.pelanggan,
  });

  String? idPemesanan;
  String? kodeTransaksi;
  int? totalHarga;
  int? totalOngkir;
  String? longitude;
  String? latitude;
  Status? status;
  List<Produk>? produk;
  DetailPengiriman? detailPengiriman;
  Pelanggan? pelanggan;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idPemesanan: json["id_pemesanan"],
        kodeTransaksi: json["kode_transaksi"],
        totalHarga: json["total_harga"],
        totalOngkir: json["total_ongkir"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        status: Status.fromJson(json["status"]),
        produk:
            List<Produk>.from(json["produk"].map((x) => Produk.fromJson(x))),
        detailPengiriman: DetailPengiriman.fromJson(json["detail_pengiriman"]),
        pelanggan: Pelanggan.fromJson(json["pelanggan"]),
      );

  Map<String, dynamic> toJson() => {
        "id_pemesanan": idPemesanan,
        "kode_transaksi": kodeTransaksi,
        "total_harga": totalHarga,
        "total_ongkir": totalOngkir,
        "longitude": longitude,
        "latitude": latitude,
        "status": status!.toJson(),
        "produk": List<dynamic>.from(produk!.map((x) => x.toJson())),
        "detail_pengiriman": detailPengiriman!.toJson(),
        "pelanggan": pelanggan!.toJson(),
      };
}

class DetailPengiriman {
  DetailPengiriman({
    this.kurir,
    this.telepone,
    this.foto,
  });

  String? kurir;
  String? telepone;
  String? foto;

  factory DetailPengiriman.fromJson(Map<String, dynamic> json) =>
      DetailPengiriman(
        kurir: json["kurir"],
        telepone: json["telepone"],
        foto: json["foto"],
      );

  Map<String, dynamic> toJson() => {
        "kurir": kurir,
        "telepone": telepone,
        "foto": foto,
      };
}

class Pelanggan {
  Pelanggan({
    this.namaPelanggan,
    this.token,
  });

  String? namaPelanggan;
  String? token;

  factory Pelanggan.fromJson(Map<String, dynamic> json) => Pelanggan(
        namaPelanggan: json["nama_pelanggan"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "nama_pelanggan": namaPelanggan,
        "token": token,
      };
}

class Produk {
  Produk({
    this.idProduk,
    this.namaProduk,
    this.qty,
    this.harga,
    this.catatan,
    this.gambar1,
  });

  String? idProduk;
  String? namaProduk;
  String? qty;
  int? harga;
  String? catatan;
  String? gambar1;

  factory Produk.fromJson(Map<String, dynamic> json) => Produk(
        idProduk: json["id_produk"],
        namaProduk: json["nama_produk"],
        qty: json["qty"],
        harga: json["harga"],
        catatan: json["catatan"],
        gambar1: json["gambar_1"],
      );

  Map<String, dynamic> toJson() => {
        "id_produk": idProduk,
        "nama_produk": namaProduk,
        "qty": qty,
        "harga": harga,
        "catatan": catatan,
        "gambar_1": gambar1,
      };
}

class Status {
  Status({
    this.idStatusPesanan,
    this.namaStatusPesanan,
  });

  String? idStatusPesanan;
  String? namaStatusPesanan;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        idStatusPesanan: json["id_status_pesanan"],
        namaStatusPesanan: json["nama_status_pesanan"],
      );

  Map<String, dynamic> toJson() => {
        "id_status_pesanan": idStatusPesanan,
        "nama_status_pesanan": namaStatusPesanan,
      };
}
