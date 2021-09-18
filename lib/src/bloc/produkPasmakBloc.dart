import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:tumbaso_warung/src/models/getBarangModel.dart';
import 'package:tumbaso_warung/src/models/getEkspedisiModel.dart';
import 'package:tumbaso_warung/src/models/getKategoriBarangModel.dart';
import 'package:tumbaso_warung/src/models/getResiModel.dart';
import 'package:tumbaso_warung/src/models/getSubKategoriModel.dart';
import 'package:tumbaso_warung/src/models/getTransaksiBarangModel.dart';
import 'package:tumbaso_warung/src/models/resLengkapiProfilModel.dart';
import 'package:tumbaso_warung/src/resources/repositories.dart';

class produkPasmakBloc {
  final _repository = Repositories();
  final _getKategoriFetcher = PublishSubject<GetKategoriBarangModel>();
  final _getSubKategoriFetcher = PublishSubject<GetSubKategoriBarangModel>();
  final _getEkspedisiFetcher = PublishSubject<GetEkspedisiModel>();
  final _getBarangFechter = PublishSubject<GetBarangModel>();
  final _getTransaksiBarangFechter = PublishSubject<GetTransaksiBarangModel>();
  final _updateStatusBarangFechter = PublishSubject<ResLengkapiProfilModel>();
  final _updateStatusTransaksiBarangFechter =
      PublishSubject<ResLengkapiProfilModel>();
  final _inputResiFecher = PublishSubject<ResLengkapiProfilModel>();
  final _cekResiFecher = PublishSubject<CekResiModel>();

  PublishSubject<GetKategoriBarangModel> get resKategori =>
      _getKategoriFetcher.stream;

  PublishSubject<GetSubKategoriBarangModel> get resSubKategori =>
      _getSubKategoriFetcher.stream;

  PublishSubject<GetEkspedisiModel> get resEkspedisi =>
      _getEkspedisiFetcher.stream;

  PublishSubject<GetBarangModel> get resBarang => _getBarangFechter.stream;

  PublishSubject<GetTransaksiBarangModel> get resTransaksiBarang =>
      _getTransaksiBarangFechter.stream;

  PublishSubject<ResLengkapiProfilModel> get resStatusBarang =>
      _updateStatusBarangFechter.stream;

  PublishSubject<ResLengkapiProfilModel> get resStatusTransaksiBarang =>
      _updateStatusTransaksiBarangFechter.stream;

  PublishSubject<ResLengkapiProfilModel> get resInputResi =>
      _inputResiFecher.stream;

  PublishSubject<CekResiModel> get resCekResi => _cekResiFecher.stream;

  getKategoriBarang() async {
    try {
      GetKategoriBarangModel getKategoriBarangModel =
          await _repository.getKategoriBarang();
      _getKategoriFetcher.sink.add(getKategoriBarangModel);
    } catch (error) {
      _getKategoriFetcher.sink.add(error);
    }
  }

  getSubKategoriBarang(String idKategori) async {
    try {
      GetSubKategoriBarangModel getSubKategoriBarangModel =
          await _repository.getSubKategoriBarang(idKategori);
      _getSubKategoriFetcher.sink.add(getSubKategoriBarangModel);
    } catch (error) {
      _getSubKategoriFetcher.sink.add(error);
    }
  }

  Future simpanProductBarang(
      File file,
      String kategori,
      String subkategori,
      String nama,
      String harga,
      String satuan,
      String berat,
      String deskripsi,
      String keterangan,
      String minimum,
      String stok) async {
    int statusCode = await _repository.simpanProdukBarang(
        file,
        kategori,
        subkategori,
        nama,
        harga,
        satuan,
        berat,
        deskripsi,
        keterangan,
        minimum,
        stok);
    return statusCode;
  }

  Future editProductBarang(
      File file,
      String id_barang,
      String kategori,
      String subkategori,
      String nama,
      String harga,
      String satuan,
      String berat,
      String deskripsi,
      String keterangan,
      String minimum,
      String stok) async {
    int statusCode = await _repository.editProdukBarang(
        file,
        id_barang,
        kategori,
        subkategori,
        nama,
        harga,
        satuan,
        berat,
        deskripsi,
        keterangan,
        minimum,
        stok);
    return statusCode;
  }

  getEkspedisi() async {
    try {
      GetEkspedisiModel getEkspedisiModel = await _repository.getEkspedisi();
      _getEkspedisiFetcher.sink.add(getEkspedisiModel);
    } catch (error) {
      _getEkspedisiFetcher.sink.add(error);
    }
  }

  getBarang() async {
    try {
      GetBarangModel getBarangModel = await _repository.getBarang();
      _getBarangFechter.sink.add(getBarangModel);
    } catch (err) {
      // _getBarangFechter.sink.add(err);
      print(err.toString());
    }
  }

  getTransaksiBarang(String status) async {
    try {
      GetTransaksiBarangModel getTransaksi =
          await _repository.getTransaksiBarang(status);
      _getTransaksiBarangFechter.sink.add(getTransaksi);
    } catch (err) {
      _getTransaksiBarangFechter.sink.add(err);
    }
  }

  updateStatusBarang(String idProduk, String status) async {
    try {
      ResLengkapiProfilModel updateStatus =
          await _repository.updateStatusBarang(idProduk, status);
      _updateStatusBarangFechter.sink.add(updateStatus);
    } catch (err) {
      _updateStatusBarangFechter.sink.add(err);
    }
  }

  updateStatusTransaksiBarang(String idPenjualan, String status) async {
    try {
      ResLengkapiProfilModel updateTransaksi =
          await _repository.updateStatusTransaksiBarang(idPenjualan, status);
      _updateStatusTransaksiBarangFechter.sink.add(updateTransaksi);
    } catch (err) {
      _updateStatusTransaksiBarangFechter.sink.add(err);
    }
  }

  inputResi(String idPenjualan, String inputResi) async {
    try {
      ResLengkapiProfilModel updateTransaksi =
          await _repository.inputResi(idPenjualan, inputResi);
      _inputResiFecher.sink.add(updateTransaksi);
    } catch (err) {
      _inputResiFecher.sink.add(err);
    }
  }

  cekResi(String kodeTransaksi) async {
    try {
      CekResiModel cekResi = await _repository.cekResi(kodeTransaksi);
      _cekResiFecher.sink.add(cekResi);
    } catch (err) {
      _cekResiFecher.sink.add(err);
    }
  }

  dispose() {
    _getKategoriFetcher.close();
    _getSubKategoriFetcher.close();
    _getEkspedisiFetcher.close();
    _getBarangFechter.close();
    _getTransaksiBarangFechter.close();
    _updateStatusBarangFechter.close();
    _updateStatusTransaksiBarangFechter.close();
    _inputResiFecher.close();
    _cekResiFecher.close();
  }
}

final blocProdukPasmak = produkPasmakBloc();
