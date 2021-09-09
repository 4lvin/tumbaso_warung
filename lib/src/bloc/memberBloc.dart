import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:tumbaso_warung/src/models/getKecamatanModel.dart';
import 'package:tumbaso_warung/src/models/getKotaModel.dart';
import 'package:tumbaso_warung/src/models/getLoginWithGmailModel.dart';
import 'package:tumbaso_warung/src/models/getProdukModel.dart';
import 'package:tumbaso_warung/src/models/getProfilModel.dart';
import 'package:tumbaso_warung/src/models/getProvinsiModel.dart';
import 'package:tumbaso_warung/src/models/getSetoranModel.dart';
import 'package:tumbaso_warung/src/models/getStatusModel.dart';
import 'package:tumbaso_warung/src/models/getTransaksiModel.dart';
import 'package:tumbaso_warung/src/models/resLengkapiProfilModel.dart';
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
  final _getSetoranFetcher = PublishSubject<GetSetoranModel>();
  final _getTransaksiFetcher = PublishSubject<GetTransaksiModel>();
  final _provinsiFetcher = PublishSubject<GetProvinsiModel>();
  final _kotaFetcher = PublishSubject<GetKotaModel>();
  final _kecamatanFetcher = PublishSubject<GetKecamatanModel>();
  final _loginGmailFetcher = PublishSubject<GetLoginWithGmailModel>();
  final _updateProfilFetcher = PublishSubject<ResLengkapiProfilModel>();
  final _getProfilFetcher = PublishSubject<GetProfilModel>();

  PublishSubject<ResLoginModel> get resLogin => _loginFetcher.stream;

  PublishSubject<GetStatusModel> get getStatus => _statusFetcher.stream;

  PublishSubject<ResUpdateStatusTokoModel> get resStatusToko =>
      _updateStatusTokoFetcher.stream;

  PublishSubject<GetProdukModel> get listProduk => _getProdukFetcher.stream;

  PublishSubject<ResUpdateStatusProdukModel> get resUpdateStatusProduk =>
      _updateStatusProdukFetcher.stream;

  PublishSubject<GetSetoranModel> get listSetoran => _getSetoranFetcher.stream;

  PublishSubject<GetTransaksiModel> get listTransaksi =>
      _getTransaksiFetcher.stream;

  PublishSubject<GetProvinsiModel> get resProvinsi => _provinsiFetcher.stream;

  PublishSubject<GetKotaModel> get resKota => _kotaFetcher.stream;

  PublishSubject<GetKecamatanModel> get resKecamatan =>
      _kecamatanFetcher.stream;

  PublishSubject<GetLoginWithGmailModel> get resLoginGmail =>
      _loginGmailFetcher.stream;

  PublishSubject<ResLengkapiProfilModel> get resUpdateProfil =>
      _updateProfilFetcher.stream;

  PublishSubject<GetProfilModel> get resGetrofil => _getProfilFetcher.stream;

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
    try {
      GetProdukModel getProdukModel =
          await _repository.getProduk(username, idPenjual, token);
      _getProdukFetcher.sink.add(getProdukModel);
    } catch (error) {
      _getProdukFetcher.sink.add(error);
    }
  }

  updateStatusProduk(
      String username, String idProduk, String status, String token) async {
    ResUpdateStatusProdukModel resUpdateStatusProdukModel =
        await _repository.updateStatusProduk(username, idProduk, status, token);
    _updateStatusProdukFetcher.sink.add(resUpdateStatusProdukModel);
  }

  Future simpanProduct(
      File file,
      String kategori,
      String subkategori,
      String nama,
      String harga,
      String berat,
      String deskripsi,
      String potongan) async {
    int statusCode = await _repository.simpanProduk(
        file, kategori, subkategori, nama, harga, berat, deskripsi, potongan);
    return statusCode;
  }

  Future updateProduct(
      File file,
      String _idproduk,
      String kategori,
      String subkategori,
      String nama,
      String harga,
      String berat,
      String deskripsi,
      String potongan) async {
    int statusCode = await _repository.updateProduct(file, _idproduk, kategori,
        subkategori, nama, harga, berat, deskripsi, potongan);
    return statusCode;
  }

  getSetoranProduct(String idPenjual) async {
    GetSetoranModel _getSetoran = await _repository.getSetoran(idPenjual);
    _getSetoranFetcher.sink.add(_getSetoran);
  }

  getTransaksi(String username, String history) async {
    GetTransaksiModel _getTransaksi =
        await _repository.getTransaksi(username, history);
    _getTransaksiFetcher.sink.add(_getTransaksi);
  }

  getProvinsi() async {
    try {
      GetProvinsiModel getProvinsiModel = await _repository.getProvinsi();
      _provinsiFetcher.sink.add(getProvinsiModel);
    } catch (error) {
      _provinsiFetcher.sink.add(error);
    }
  }

  getKota(String kodeProv) async {
    try {
      GetKotaModel getKotaModel = await _repository.getKota(kodeProv);
      _kotaFetcher.sink.add(getKotaModel);
    } catch (error) {
      _kotaFetcher.sink.add(error);
    }
  }

  getKecamatan(String kodeKota) async {
    try {
      GetKecamatanModel getKecamatanModel =
          await _repository.getKecamatan(kodeKota);
      _kecamatanFetcher.sink.add(getKecamatanModel);
    } catch (error) {
      _kecamatanFetcher.sink.add(error);
    }
  }

  loginGmail(String email, String foto, String nama, String token) async {
    try {
      GetLoginWithGmailModel getLoginWithGmailModel =
          await _repository.loginWIthGmail(email, foto, nama, token);
      _loginGmailFetcher.sink.add(getLoginWithGmailModel);
    } catch (error) {
      _loginGmailFetcher.sink.add(error);
    }
  }

  lengkapiProfil(
      String email,
      String nama,
      String provinsiId,
      String kotaId,
      String kecId,
      String alamat,
      String longitude,
      String latitude,
      String telephone,
      String kurir,
      String token,
      String agen) async {
    try {
      ResLengkapiProfilModel resLengkapiProfilModel =
          await _repository.lengkapiProfil(
              email,
              nama,
              provinsiId,
              kotaId,
              kecId,
              alamat,
              longitude,
              latitude,
              telephone,
              kurir,
              token,
              agen);
      _updateProfilFetcher.sink.add(resLengkapiProfilModel);
    } catch (error) {
      _updateProfilFetcher.sink.add(error);
    }
  }

  getProfil() async {
    try {
      GetProfilModel getProfilModel = await _repository.getProfil();
      _getProfilFetcher.sink.add(getProfilModel);
    } catch (error) {
      _getProfilFetcher.sink.add(error);
    }
  }

  dispose() {
    _loginFetcher.close();
    _statusFetcher.close();
    _provinsiFetcher.close();
    _kotaFetcher.close();
    _kecamatanFetcher.close();
    _updateStatusTokoFetcher.close();
    _getProdukFetcher.close();
    _updateStatusProdukFetcher.close();
    _getSetoranFetcher.close();
    _getTransaksiFetcher.close();
    _loginGmailFetcher.close();
    _updateProfilFetcher.close();
    _getProfilFetcher.close();
  }
}

final blocMember = MemberBloc();
