import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as client;
import 'package:tumbaso_warung/src/models/getBarangModel.dart';
import 'package:tumbaso_warung/src/models/getEkspedisiModel.dart';
import 'package:tumbaso_warung/src/models/getKategoriBarangModel.dart';
import 'package:tumbaso_warung/src/models/getKecamatanModel.dart';
import 'package:tumbaso_warung/src/models/getKotaModel.dart';
import 'package:tumbaso_warung/src/models/getLoginWithGmailModel.dart';
import 'package:tumbaso_warung/src/models/getProdukModel.dart';
import 'package:tumbaso_warung/src/models/getProfilModel.dart';
import 'package:tumbaso_warung/src/models/getProvinsiModel.dart';
import 'package:tumbaso_warung/src/models/getSetoranModel.dart';
import 'package:tumbaso_warung/src/models/getStatusModel.dart';
import 'package:tumbaso_warung/src/models/getSubKategoriModel.dart';
import 'package:tumbaso_warung/src/models/getTransaksiModel.dart';
import 'package:tumbaso_warung/src/models/resLengkapiProfilModel.dart';

import 'dart:io';

import 'package:tumbaso_warung/src/models/resLoginModel.dart';
import 'package:tumbaso_warung/src/models/resSubkategoriModel.dart';
import 'package:tumbaso_warung/src/models/resUpdateStatusProdukModel.dart';
import 'package:tumbaso_warung/src/models/resUpdateStatusTokoModel.dart';
import 'package:tumbaso_warung/src/pref/preferences.dart';
import 'package:path/path.dart' as path;
import 'package:async/async.dart';

class ApiProviders {
  String url = "https://jongjava.tech/tumbas/restapi";

  // String url2 = "https://pasar.benmakmur.id/restapi";

  String url2 = "https://tumbasonline.com/pasarmakmur/restapi";

  Future getSubkategori(String idKategori) async {
    var body = jsonEncode({'id_kategori': idKategori});
    try {
      final checkid = await client
          .post("$url/produk/get_subkategori",
              headers: {"Content-Type": "application/json"}, body: body)
          .timeout(const Duration(seconds: 11));
      if (checkid.statusCode == 200) {
        return ResSubkategoriModel.fromJson(json.decode(checkid.body));
      } else if (checkid.statusCode == 404) {
        return ResSubkategoriModel.fromJson(json.decode(checkid.body));
      } else {
        throw Exception('Failure response');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future login(String username, String password) async {
    var body =
        jsonEncode({'username': username, 'password': password, "token": ""});
    try {
      final checkid = await client
          .post("$url/penjual/login",
              headers: {"Content-Type": "application/json"}, body: body)
          .timeout(const Duration(seconds: 11));
      if (checkid.statusCode == 200) {
        return ResLoginModel.fromJson(json.decode(checkid.body));
      } else if (checkid.statusCode == 404) {
        return ResLoginModel.fromJson(json.decode(checkid.body));
      } else {
        throw Exception('Failure response');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future status(String idPenjual) async {
    var body = jsonEncode({'id_penjual': idPenjual});
    try {
      final checkid = await client
          .post("$url/penjual/get_penjual",
              headers: {"Content-Type": "application/json"}, body: body)
          .timeout(const Duration(seconds: 11));
      if (checkid.statusCode == 200) {
        return GetStatusModel.fromJson(json.decode(checkid.body));
      } else if (checkid.statusCode == 404) {
        return GetStatusModel.fromJson(json.decode(checkid.body));
      } else {
        throw Exception('Failure response');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future updateStatusToko(String username, String status, String token) async {
    var body = jsonEncode({'email': username, 'status': status});
    try {
      final checkid = await client
          .post("$url/penjual/put_status_toko",
              headers: {
                "Content-Type": "application/json",
                "Authorization": token
              },
              body: body)
          .timeout(const Duration(seconds: 11));
      if (checkid.statusCode == 200) {
        return ResUpdateStatusTokoModel.fromJson(json.decode(checkid.body));
      } else if (checkid.statusCode == 404) {
        return ResUpdateStatusTokoModel.fromJson(json.decode(checkid.body));
      } else {
        throw Exception('Failure response');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future getProduk(String username, String idPenjual, String token) async {
    var body = jsonEncode({'email': username, 'penjual_id': idPenjual});
    try {
      final checkid = await client
          .post("$url/penjual/get_produk_penjual",
              headers: {
                "Content-Type": "application/json",
                "Authorization": token
              },
              body: body)
          .timeout(const Duration(seconds: 11));
      if (checkid.statusCode == 200) {
        return GetProdukModel.fromJson(json.decode(checkid.body));
      } else if (checkid.statusCode == 404) {
        return GetProdukModel.fromJson(json.decode(checkid.body));
      } else {
        throw Exception('Failure response');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future getSetoran(String idPenjual) async {
    var body = jsonEncode({'id_penjual': idPenjual});
    try {
      final checkid = await client
          .post("$url/penjual/get_setor",
              headers: {"Content-Type": "application/json"}, body: body)
          .timeout(const Duration(seconds: 11));
      if (checkid.statusCode == 200) {
        return GetSetoranModel.fromJson(json.decode(checkid.body));
      } else {
        throw Exception('Failure response');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future getTransaksi(String username, String history) async {
    var body = jsonEncode({'email': username, 'history': history});
    String _token;
    await getToken().then((value) {
      _token = value;
    });
    try {
      final checkid = await client
          .post("$url/penjual/get_transaksi",
              headers: {
                "Content-Type": "application/json",
                "Authorization": _token
              },
              body: body)
          .timeout(const Duration(seconds: 13));
      if (checkid.statusCode == 200) {
        return GetTransaksiModel.fromJson(json.decode(checkid.body));
      } else if (checkid.statusCode == 404) {
        return GetProdukModel.fromJson(json.decode(checkid.body));
      } else {
        throw Exception('Failure response');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future updateStatusProduk(
      String username, String idProduk, String status, String token) async {
    var body = jsonEncode(
        {'email': username, 'id_produk': idProduk, 'status': status});
    try {
      final checkid = await client
          .post("$url/penjual/put_status_produk",
              headers: {
                "Content-Type": "application/json",
                "Authorization": token
              },
              body: body)
          .timeout(const Duration(seconds: 11));
      if (checkid.statusCode == 200) {
        return ResUpdateStatusProdukModel.fromJson(json.decode(checkid.body));
      } else if (checkid.statusCode == 404) {
        return ResUpdateStatusProdukModel.fromJson(json.decode(checkid.body));
      } else {
        throw Exception('Failure response');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future simpanProduk(
      File file,
      String kategori,
      String subkategori,
      String nama,
      String harga,
      String berat,
      String deskripsi,
      String potongan) async {
    String _token;
    String _username;
    await getToken().then((value) {
      _token = value;
    });
    await getEmail().then((value) {
      _username = value;
    });
    try {
      var uri = Uri.parse("$url/penjual/create_produk");
      var request = new client.MultipartRequest("POST", uri);
      request.headers['authorization'] = _token;

      request.fields['email'] = _username;
      request.fields['kategori_id'] = kategori;
      request.fields['subkategori_id'] = subkategori;
      request.fields['nama_produk'] = nama;
      request.fields['harga_pokok'] = harga;
      request.fields['potongan'] = potongan;
      request.fields['berat'] = berat;
      request.fields['deskripsi'] = deskripsi;
      request.fields['aktif'] = "0";
      request.fields['utama'] = "0";

      if (file != null) {
        request.files.add(client.MultipartFile(
            "file",
            // ignore: deprecated_member_use
            client.ByteStream(DelegatingStream.typed(file.openRead())),
            await file.length(),
            filename: path.basename(file.path)));
      } else {
        request.fields['file'] = "";
      }
      int statusResponse;
      await request
          .send()
          .then((result) async {
            await client.Response.fromStream(result).then((response) {
              print(response.statusCode);
              statusResponse = response.statusCode;
            });
          })
          .catchError((err) => print('error : ' + err.toString()))
          .whenComplete(() {});
      return statusResponse;
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
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
    String _token;
    String _username;
    await getToken().then((value) {
      _token = value;
    });
    await getEmail().then((value) {
      _username = value;
    });
    try {
      var uri = Uri.parse("$url/penjual/update_produk");
      var request = new client.MultipartRequest("POST", uri);
      request.headers['authorization'] = _token;

      request.fields['email'] = _username;
      request.fields['id_produk'] = _idproduk;
      request.fields['kategori_id'] = kategori;
      request.fields['subkategori_id'] = subkategori;
      request.fields['nama_produk'] = nama;
      request.fields['harga_pokok'] = harga;
      request.fields['potongan'] = potongan;
      request.fields['berat'] = berat;
      request.fields['deskripsi'] = deskripsi;
      request.fields['aktif'] = "0";
      request.fields['utama'] = "0";

      if (file != null) {
        request.files.add(client.MultipartFile(
            "file",
            // ignore: deprecated_member_use
            client.ByteStream(DelegatingStream.typed(file.openRead())),
            await file.length(),
            filename: path.basename(file.path)));
      } else {
        request.fields['file'] = "";
      }
      int statusResponse;
      await request
          .send()
          .then((result) async {
            await client.Response.fromStream(result).then((response) {
              statusResponse = response.statusCode;
            });
          })
          .catchError((err) => print('error : ' + err.toString()))
          .whenComplete(() {});
      return statusResponse;
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future getProvinsi() async {
    try {
      final prov = await client.post("$url/umum/get_provinsi", headers: {
        "Content-Type": "application/json"
      }).timeout(const Duration(seconds: 11));
      if (prov.statusCode == 200) {
        return GetProvinsiModel.fromJson(json.decode(prov.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future getKota(String kodeProv) async {
    try {
      var body = jsonEncode({'id_provinsi': kodeProv});
      final data = await client.post("$url/umum/get_kabupaten",
          body: body,
          headers: {
            "Content-Type": "application/json"
          }).timeout(const Duration(seconds: 11));
      if (data.statusCode == 200) {
        return GetKotaModel.fromJson(json.decode(data.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future getKecamatan(String kodeKota) async {
    try {
      var body = jsonEncode({'id_kabupaten': kodeKota});
      final data = await client.post("$url/umum/get_kecamatan",
          body: body,
          headers: {
            "Content-Type": "application/json"
          }).timeout(const Duration(seconds: 11));
      if (data.statusCode == 200) {
        return GetKecamatanModel.fromJson(json.decode(data.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future loginWithGmail(
      String email, String foto, String nama, String token) async {
    var body = jsonEncode(
        {'email': email, 'foto': foto, 'nama': nama, 'token': token});
    try {
      final checkId = await client
          .post("$url/penjual/login_gmail",
              headers: {"Content-Type": "application/json"}, body: body)
          .timeout(const Duration(seconds: 11));
      if (checkId.statusCode == 200) {
        return GetLoginWithGmailModel.fromJson(json.decode(checkId.body));
      } else if (checkId.statusCode == 404) {
        return GetLoginWithGmailModel.fromJson(json.decode(checkId.body));
      } else {
        throw Exception('Failure response');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future lengkapiProfil(
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
      String token) async {
    var body = jsonEncode({
      'email': email,
      'nama': nama,
      'provinsi_id': provinsiId,
      'kota_id': kotaId,
      'kecamatan_id': kecId,
      'alamat': alamat,
      'longitude': longitude,
      'latitude': latitude,
      'telepone': telephone,
      'kurir': kurir
    });
    try {
      final checkId = await client
          .post("$url/penjual/ubah_profil",
              headers: {
                "Content-Type": "application/json",
                "Authorization": token
              },
              body: body)
          .timeout(const Duration(seconds: 11));
      if (checkId.statusCode == 200) {
        return ResLengkapiProfilModel.fromJson(json.decode(checkId.body));
      } else if (checkId.statusCode == 404) {
        return ResLengkapiProfilModel.fromJson(json.decode(checkId.body));
      } else {
        throw Exception('Failure response');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future getKategoriBarang() async {
    try {
      final prov = await client.post("$url2/umum/get_kategori_produk",
          headers: {
            "Content-Type": "application/json"
          }).timeout(const Duration(seconds: 11));
      if (prov.statusCode == 200) {
        return GetKategoriBarangModel.fromJson(json.decode(prov.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future getSubKategoriBarang(String idKategori) async {
    var body = jsonEncode({
      'id_kategori': idKategori,
    });
    try {
      final prov = await client
          .post("$url2/umum/get_subkategori_produk",
              headers: {"Content-Type": "application/json"}, body: body)
          .timeout(const Duration(seconds: 11));
      if (prov.statusCode == 200) {
        return GetSubKategoriBarangModel.fromJson(json.decode(prov.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future getBarang() async {
    String _idPenjual;
    String _token;
    await getToken().then((value) {
      _token = value;
    });
    await getKdPasmak().then((value) {
      _idPenjual = value;
    });
    var body = jsonEncode({
      'id_penjual': _idPenjual,
    });
    try {
      final barang = await client
          .post("$url2/produk/get_produk",
              headers: {
                "Content-Type": "application/json",
                "Authorization": _token
              },
              body: body)
          .timeout(const Duration(seconds: 11));
      if (barang.statusCode == 200) {
        return GetBarangModel.fromJson(json.decode(barang.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future simpanProdukBarang(
      File file,
      String kategori,
      String subkategori,
      String nama,
      String harga,
      String satuan,
      String berat,
      String deskripsi,
      String keterangan,
      String minimum) async {
    String _token;
    String _username;
    await getToken().then((value) {
      _token = value;
    });
    await getEmail().then((value) {
      _username = value;
    });
    try {
      var uri = Uri.parse("$url2/penjual/create_produk");
      var request = new client.MultipartRequest("POST", uri);
      request.headers['authorization'] = _token;

      request.fields['email'] = _username;
      request.fields['kategori_id'] = kategori;
      request.fields['subkategori_id'] = subkategori;
      request.fields['nama_produk'] = nama;
      request.fields['harga'] = harga;
      request.fields['satuan'] = satuan;
      request.fields['berat'] = berat;
      request.fields['deskripsi'] = deskripsi;
      request.fields['keterangan'] = keterangan;
      request.fields['minimum'] = minimum;

      if (file != null) {
        request.files.add(client.MultipartFile(
            "file",
            // ignore: deprecated_member_use
            client.ByteStream(DelegatingStream.typed(file.openRead())),
            await file.length(),
            filename: path.basename(file.path)));
      } else {
        request.fields['file'] = "";
      }
      int statusResponse;
      await request
          .send()
          .then((result) async {
            await client.Response.fromStream(result).then((response) {
              print(response.statusCode);
              statusResponse = response.statusCode;
            });
          })
          .catchError((err) => print('error : ' + err.toString()))
          .whenComplete(() {});
      return statusResponse;
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future getProfil(String email) async {
    var body = jsonEncode({
      'email': email,
    });
    try {
      final prov = await client
          .post("$url2/penjual/get_profil",
              headers: {"Content-Type": "application/json"}, body: body)
          .timeout(const Duration(seconds: 11));
      if (prov.statusCode == 200) {
        return GetProfilModel.fromJson(json.decode(prov.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future getEkspedisi() async {
    try {
      final prov = await client.post("$url2/umum/get_kurir", headers: {
        "Content-Type": "application/json"
      }).timeout(const Duration(seconds: 11));
      if (prov.statusCode == 200) {
        return GetEkspedisiModel.fromJson(json.decode(prov.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }
}
