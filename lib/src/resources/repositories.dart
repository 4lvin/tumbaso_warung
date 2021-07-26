import 'dart:io';

import 'package:tumbaso_warung/src/resources/apiProvider.dart';

class Repositories {
  final apiProvider = ApiProviders();

  Future getSubkategori(String idKategori) =>
      apiProvider.getSubkategori(idKategori);

  Future login(String username, String password) =>
      apiProvider.login(username, password);

  Future status(String idPenjual) => apiProvider.status(idPenjual);

  Future updateStatusToko(String username, String status, String token) =>
      apiProvider.updateStatusToko(username, status, token);

  Future getProduk(String username, String idPenjual, String token) =>
      apiProvider.getProduk(username, idPenjual, token);

  Future updateStatusProduk(
          String username, String idProduk, String status, String token) =>
      apiProvider.updateStatusProduk(username, idProduk, status, token);

  Future simpanProduk(
          File file,
          String kategori,
          String subkategori,
          String nama,
          String harga,
          String berat,
          String deskripsi,
          String potongan) =>
      apiProvider.simpanProduk(
          file, kategori, subkategori, nama, harga, berat, deskripsi, potongan);

  Future updateProduct(
          File file,
          String _idproduk,
          String kategori,
          String subkategori,
          String nama,
          String harga,
          String berat,
          String deskripsi,
          String potongan) =>
      apiProvider.updateProduct(file, _idproduk, kategori, subkategori, nama,
          harga, berat, deskripsi, potongan);

  Future getSetoran(String idPenjual) => apiProvider.getSetoran(idPenjual);

  Future getTransaksi(String username, String history) =>
      apiProvider.getTransaksi(username, history);
}
