// To parse this JSON data, do
//
//     final getBarangModel = getBarangModelFromJson(jsonString);

import 'dart:convert';

class GetBarangModel {
  GetBarangModel({
    this.status,
    this.data,
    this.message,
  });

  bool status;
  List<DatumBarang> data;
  String message;

  factory GetBarangModel.fromRawJson(String str) =>
      GetBarangModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetBarangModel.fromJson(Map<String, dynamic> json) => GetBarangModel(
        status: json["status"],
        data: List<DatumBarang>.from(
            json["data"].map((x) => DatumBarang.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class DatumBarang {
  DatumBarang({
    this.idProduk,
    this.idKategoriProduk,
    this.idKategoriProdukSub,
    this.idReseller,
    this.namaProduk,
    this.satuan,
    this.harga,
    this.tentangProduk,
    this.keterangan,
    this.aktif,
    this.minimum,
    this.feeProduk,
    this.gambar,
  });

  String idProduk;
  dynamic idKategoriProduk;
  dynamic idKategoriProdukSub;
  String idReseller;
  String namaProduk;
  String satuan;
  String harga;
  dynamic tentangProduk;
  String keterangan;
  String aktif;
  String minimum;
  dynamic feeProduk;
  String gambar;

  factory DatumBarang.fromRawJson(String str) =>
      DatumBarang.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DatumBarang.fromJson(Map<String, dynamic> json) => DatumBarang(
        idProduk: json["id_produk"],
        idKategoriProduk: json["id_kategori_produk"],
        idKategoriProdukSub: json["id_kategori_produk_sub"],
        idReseller: json["id_reseller"],
        namaProduk: json["nama_produk"],
        satuan: json["satuan"],
        harga: json["harga"],
        tentangProduk: json["tentang_produk"],
        keterangan: json["keterangan"],
        aktif: json["aktif"],
        minimum: json["minimum"],
        feeProduk: json["fee_produk"],
        gambar: json["gambar"],
      );

  Map<String, dynamic> toJson() => {
        "id_produk": idProduk,
        "id_kategori_produk": idKategoriProduk,
        "id_kategori_produk_sub": idKategoriProdukSub,
        "id_reseller": idReseller,
        "nama_produk": namaProduk,
        "satuan": satuan,
        "harga": harga,
        "tentang_produk": tentangProduk,
        "keterangan": keterangan,
        "aktif": aktif,
        "minimum": minimum,
        "fee_produk": feeProduk,
        "gambar": gambar,
      };
}
