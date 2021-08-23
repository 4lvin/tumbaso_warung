import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:tumbaso_warung/src/models/getEkspedisiModel.dart';
import 'package:tumbaso_warung/src/models/getKategoriBarangModel.dart';
import 'package:tumbaso_warung/src/models/getSubKategoriModel.dart';
import 'package:tumbaso_warung/src/resources/repositories.dart';

class produkPasmakBloc {
  final _repository = Repositories();
  final _getKategoriFetcher = PublishSubject<GetKategoriBarangModel>();
  final _getSubKategoriFetcher = PublishSubject<GetSubKategoriBarangModel>();
  final _getEkspedisiFetcher = PublishSubject<GetEkspedisiModel>();

  PublishSubject<GetKategoriBarangModel> get resKategori => _getKategoriFetcher.stream;

  PublishSubject<GetSubKategoriBarangModel> get resSubKategori => _getSubKategoriFetcher.stream;

  PublishSubject<GetEkspedisiModel> get resEkspedisi => _getEkspedisiFetcher.stream;

  getKategoriBarang() async {
    try {
      GetKategoriBarangModel getKategoriBarangModel = await _repository.getKategoriBarang();
      _getKategoriFetcher.sink.add(getKategoriBarangModel);
    } catch (error) {
      _getKategoriFetcher.sink.add(error);
    }
  }

  getSubKategoriBarang(String idKategori) async {
    try {
      GetSubKategoriBarangModel getSubKategoriBarangModel = await _repository.getSubKategoriBarang(idKategori);
      _getSubKategoriFetcher.sink.add(getSubKategoriBarangModel);
    } catch (error) {
      _getSubKategoriFetcher.sink.add(error);
    }
  }

  Future simpanProductBarang(File file, String kategori, String subkategori, String nama, String harga, String satuan,
      String berat, String deskripsi, String keterangan, String minimum) async {
    int statusCode = await _repository.simpanProdukBarang(
        file, kategori, subkategori, nama, harga, satuan, berat, deskripsi, keterangan, minimum);
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

  dispose() {
    _getKategoriFetcher.close();
    _getSubKategoriFetcher.close();
    _getEkspedisiFetcher.close();
  }
}

final blocProdukPasmak = produkPasmakBloc();
