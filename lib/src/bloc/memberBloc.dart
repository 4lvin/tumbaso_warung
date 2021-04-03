import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:tumbaso_warung/src/models/getProdukModel.dart';
import 'package:tumbaso_warung/src/models/getStatusModel.dart';
import 'package:tumbaso_warung/src/models/resFileUploadModel.dart';
import 'package:tumbaso_warung/src/models/resLoginModel.dart';
import 'package:tumbaso_warung/src/models/resSubkategoriModel.dart';
import 'package:tumbaso_warung/src/models/resUpdateStatusProdukModel.dart';
import 'package:tumbaso_warung/src/models/resUpdateStatusTokoModel.dart';
import 'package:tumbaso_warung/src/resources/repositories.dart';

class MemberBloc {
  final _repository = Repositories();
  final _loginFetcher = PublishSubject<ResLoginModel>();
  final _statusFetcher = PublishSubject<GetStatusModel>();
  final _updateStatusTokoFetcher = PublishSubject<ResUpdateStatusTokoModel>();
  final _getProdukFetcher = PublishSubject<GetProdukModel>();
  final _updateStatusProdukFetcher =
      PublishSubject<ResUpdateStatusProdukModel>();

  PublishSubject<ResLoginModel> get resLogin => _loginFetcher.stream;
  PublishSubject<GetStatusModel> get getStatus => _statusFetcher.stream;
  PublishSubject<ResUpdateStatusTokoModel> get resStatusToko =>
      _updateStatusTokoFetcher.stream;
  PublishSubject<GetProdukModel> get listProduk => _getProdukFetcher.stream;
  PublishSubject<ResUpdateStatusProdukModel> get resUpdateStatusProduk =>
      _updateStatusProdukFetcher.stream;

  Future uploadFile(File file) async {
    try {
      String files = await _repository.uploadFile(file);
      return files;
    } catch (e) {
      print(e);
    }
  }

  getSubkategori(String idKategori) async {
    ResSubkategoriModel getSubkategori =
        await _repository.getSubkategori(idKategori);
    return getSubkategori;
  }

  login(String username, String password) async {
    ResLoginModel getResLogin = await _repository.login(username, password);
    _loginFetcher.sink.add(getResLogin);
  }

  status(String idPenjual) async {
    GetStatusModel getStatusModel = await _repository.status(idPenjual);
    _statusFetcher.sink.add(getStatusModel);
  }

  updateStatusToko(String username, String status, String token) async {
    ResUpdateStatusTokoModel resUpdateStatusTokoModel =
        await _repository.updateStatusToko(username, status, token);
    _updateStatusTokoFetcher.sink.add(resUpdateStatusTokoModel);
  }

  getProduk(String username, String idPenjual, String token) async {
    GetProdukModel getProdukModel =
        await _repository.getProduk(username, idPenjual, token);
    _getProdukFetcher.sink.add(getProdukModel);
  }

  updateStatusProduk(
      String username, String idProduk, String status, String token) async {
    ResUpdateStatusProdukModel resUpdateStatusProdukModel =
        await _repository.updateStatusProduk(username, idProduk, status, token);
    _updateStatusProdukFetcher.sink.add(resUpdateStatusProdukModel);
  }

  Future simpanProduct(
      String kategori,
      String subkategori,
      String nama,
      String harga,
      String berat,
      String deskripsi,
      String potongan,
      String gambar_1) async {
    int statusCode = await _repository.simpanProduk(kategori, subkategori, nama,
        harga, berat, deskripsi, potongan, gambar_1);
    return statusCode;
  }

  dispose() {
    _loginFetcher.close();
    _statusFetcher.close();
    _updateStatusTokoFetcher.close();
    _getProdukFetcher.close();
    _updateStatusProdukFetcher.close();
  }
}

final blocMember = MemberBloc();
