// To parse this JSON data, do
//
//     final getProdukModel = getProdukModelFromJson(jsonString);

import 'dart:convert';

GetProdukModel getProdukModelFromJson(String str) =>
    GetProdukModel.fromJson(json.decode(str));

String getProdukModelToJson(GetProdukModel data) => json.encode(data.toJson());

class GetProdukModel {
  GetProdukModel({
    this.status,
    this.data,
    this.message,
  });

  bool status;
  List<Datum> data;
  String message;

  factory GetProdukModel.fromJson(Map<String, dynamic> json) => GetProdukModel(
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
    this.idProduk,
    this.kategori,
    this.idSubkategori,
    this.namaProduk,
    this.hargaJual,
    this.berat,
    this.potongan,
    this.deskripsi,
    this.aktif,
    this.penjual,
    this.gambar,
  });

  String idProduk;
  Kategori kategori;
  String idSubkategori;
  String namaProduk;
  String hargaJual;
  String berat;
  String potongan;
  String deskripsi;
  String aktif;
  Penjual penjual;
  Gambar gambar;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idProduk: json["id_produk"],
        kategori: Kategori.fromJson(json["kategori"]),
        idSubkategori: json["id_subkategori"],
        namaProduk: json["nama_produk"],
        hargaJual: json["harga_jual"],
        berat: json["berat"],
        potongan: json["potongan"],
        deskripsi: json["deskripsi"],
        aktif: json["aktif"],
        penjual: Penjual.fromJson(json["penjual"]),
        gambar: Gambar.fromJson(json["gambar"]),
      );

  Map<String, dynamic> toJson() => {
        "id_produk": idProduk,
        "kategori": kategori.toJson(),
        "id_subkategori": idSubkategori,
        "nama_produk": namaProduk,
        "harga_jual": hargaJual,
        "berat": berat,
        "potongan": potongan,
        "deskripsi": deskripsi,
        "aktif": aktif,
        "penjual": penjual.toJson(),
        "gambar": gambar.toJson(),
      };
}

class Gambar {
  Gambar({
    this.gambar1,
    this.gambar2,
    this.gambar3,
  });

  String gambar1;
  String gambar2;
  String gambar3;

  factory Gambar.fromJson(Map<String, dynamic> json) => Gambar(
        gambar1: json["gambar_1"],
        gambar2: json["gambar_2"],
        gambar3: json["gambar_3"],
      );

  Map<String, dynamic> toJson() => {
        "gambar_1": gambar1,
        "gambar_2": gambar2,
        "gambar_3": gambar3,
      };
}

class Kategori {
  Kategori({
    this.idKategori,
    this.namaKategori,
  });

  String idKategori;
  String namaKategori;

  factory Kategori.fromJson(Map<String, dynamic> json) => Kategori(
        idKategori: json["id_kategori"],
        namaKategori: json["nama_kategori"],
      );

  Map<String, dynamic> toJson() => {
        "id_kategori": idKategori,
        "nama_kategori": namaKategori,
      };
}

class Penjual {
  Penjual({
    this.penjualId,
    this.nama,
    this.namaToko,
    this.status,
    this.kecamatanId,
    this.alamat,
    this.longitude,
    this.latitude,
  });

  String penjualId;
  String nama;
  String namaToko;
  String status;
  String kecamatanId;
  String alamat;
  String longitude;
  String latitude;

  factory Penjual.fromJson(Map<String, dynamic> json) => Penjual(
        penjualId: json["penjual_id"],
        nama: json["nama"],
        namaToko: json["nama_toko"],
        status: json["status"],
        kecamatanId: json["kecamatan_id"],
        alamat: json["alamat"],
        longitude: json["longitude"],
        latitude: json["latitude"],
      );

  Map<String, dynamic> toJson() => {
        "penjual_id": penjualId,
        "nama": nama,
        "nama_toko": namaToko,
        "status": status,
        "kecamatan_id": kecamatanId,
        "alamat": alamat,
        "longitude": longitude,
        "latitude": latitude,
      };
}
