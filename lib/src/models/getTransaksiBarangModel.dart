// To parse this JSON data, do
//
//     final getTransaksiBarangModel = getTransaksiBarangModelFromJson(jsonString);

import 'dart:convert';

class GetTransaksiBarangModel {
  GetTransaksiBarangModel({
    this.status,
    this.data,
    this.message,
  });

  bool? status;
  List<TransaksiBarangDatum>? data;
  String? message;

  factory GetTransaksiBarangModel.fromRawJson(String str) =>
      GetTransaksiBarangModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetTransaksiBarangModel.fromJson(Map<String, dynamic> json) =>
      GetTransaksiBarangModel(
        status: json["status"],
        data: List<TransaksiBarangDatum>.from(
            json["data"].map((x) => TransaksiBarangDatum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class TransaksiBarangDatum {
  TransaksiBarangDatum({
    this.idPenjualan,
    this.kodeTransaksi,
    this.idPembeli,
    this.pembeli,
    this.idPenjual,
    this.noResi,
    this.kurir,
    this.ongkir,
    this.keterangan,
    this.proses,
    this.pemesananDetail,
    this.waktuTransaksi,
  });

  String? idPenjualan;
  String? kodeTransaksi;
  String? idPembeli;
  Pembeli? pembeli;
  String? idPenjual;
  dynamic noResi;
  String? kurir;
  String? ongkir;
  String? keterangan;
  String? proses;
  List<PemesananDetail>? pemesananDetail;
  DateTime? waktuTransaksi;

  factory TransaksiBarangDatum.fromRawJson(String str) =>
      TransaksiBarangDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransaksiBarangDatum.fromJson(Map<String, dynamic> json) =>
      TransaksiBarangDatum(
        idPenjualan: json["id_penjualan"],
        kodeTransaksi: json["kode_transaksi"],
        idPembeli: json["id_pembeli"],
        pembeli: Pembeli.fromJson(json["pembeli"]),
        idPenjual: json["id_penjual"],
        noResi: json["no_resi"],
        kurir: json["kurir"],
        ongkir: json["ongkir"],
        keterangan: json["keterangan"],
        proses: json["proses"],
        pemesananDetail: List<PemesananDetail>.from(
            json["pemesanan_detail"].map((x) => PemesananDetail.fromJson(x))),
        waktuTransaksi: DateTime.parse(json["waktu_transaksi"]),
      );

  Map<String, dynamic> toJson() => {
        "id_penjualan": idPenjualan,
        "kode_transaksi": kodeTransaksi,
        "id_pembeli": idPembeli,
        "pembeli": pembeli!.toJson(),
        "id_penjual": idPenjual,
        "no_resi": noResi,
        "kurir": kurir,
        "ongkir": ongkir,
        "keterangan": keterangan,
        "proses": proses,
        "pemesanan_detail":
            List<dynamic>.from(pemesananDetail!.map((x) => x.toJson())),
        "waktu_transaksi": waktuTransaksi!.toIso8601String(),
      };
}

class Pembeli {
  Pembeli({
    this.namaLengkap,
    this.email,
    this.alamatLengkap,
  });

  String? namaLengkap;
  String? email;
  String? alamatLengkap;

  factory Pembeli.fromRawJson(String str) => Pembeli.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pembeli.fromJson(Map<String, dynamic> json) => Pembeli(
        namaLengkap: json["nama_lengkap"],
        email: json["email"],
        alamatLengkap: json["alamat_lengkap"],
      );

  Map<String, dynamic> toJson() => {
        "nama_lengkap": namaLengkap,
        "email": email,
        "alamat_lengkap": alamatLengkap,
      };
}

class PemesananDetail {
  PemesananDetail({
    this.idProduk,
    this.namaProduk,
    this.qty,
    this.harga,
    this.potongan,
  });

  int? idProduk;
  String? namaProduk;
  int? qty;
  int? harga;
  int? potongan;

  factory PemesananDetail.fromRawJson(String str) =>
      PemesananDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PemesananDetail.fromJson(Map<String, dynamic> json) =>
      PemesananDetail(
        idProduk: json["id_produk"],
        namaProduk: json["nama_produk"],
        qty: json["qty"],
        harga: json["harga"],
        potongan: json["potongan"],
      );

  Map<String, dynamic> toJson() => {
        "id_produk": idProduk,
        "nama_produk": namaProduk,
        "qty": qty,
        "harga": harga,
        "potongan": potongan,
      };
}
