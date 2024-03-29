import 'dart:io';

import 'package:tumbaso_warung/src/resources/apiProvider.dart';

class Repositories {
  final apiProvider = ApiProviders();

  Future getSubkategori(String idKategori) =>
      apiProvider.getSubkategori(idKategori);

  Future login(String email, String password) =>
      apiProvider.login(email, password);

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

  Future getProvinsi() => apiProvider.getProvinsi();

  Future getKota(String kodeProv) => apiProvider.getKota(kodeProv);

  Future getKecamatan(String kodeKota) => apiProvider.getKecamatan(kodeKota);

  Future loginWIthGmail(String email, String foto, String nama, String token) =>
      apiProvider.loginWithGmail(email, foto, nama, token);

  Future lengkapiProfil(
          String email,
          String nama,
          String namaToko,
          String provinsiId,
          String kotaId,
          String kecId,
          String alamat,
          String longitude,
          String latitude,
          String telephone,
          String kurir,
          String token,
          String agen) =>
      apiProvider.lengkapiProfil(email, nama, namaToko, provinsiId, kotaId,
          kecId, alamat, longitude, latitude, telephone, kurir, token, agen);

  Future getKategoriBarang() => apiProvider.getKategoriBarang();

  Future getSubKategoriBarang(String idKategori) =>
      apiProvider.getSubKategoriBarang(idKategori);

  Future getProfil(String email, String token) =>
      apiProvider.getProfil(email, token);
}
