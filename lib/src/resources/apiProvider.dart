import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as client;
import 'package:tumbaso_warung/src/models/getProdukModel.dart';
import 'package:tumbaso_warung/src/models/getSetoranModel.dart';
import 'package:tumbaso_warung/src/models/getStatusModel.dart';
import 'package:tumbaso_warung/src/models/resFileUploadModel.dart';

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
  // String url = "https://tumbasonline.com/restapi";

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
      print("$url/penjual/login");
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
    var body = jsonEncode({'username': username, 'status': status});
    try {
      final checkid = await client
          .post("$url/penjual/put_status_toko",
              headers: {
                "Content-Type": "application/json",
                "Authorization": token
              },
              body: body)
          .timeout(const Duration(seconds: 11));
      print(checkid.body);
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
    var body = jsonEncode({'penjual_id': idPenjual, 'username': username});
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

  Future updateStatusProduk(
      String username, String idProduk, String status, String token) async {
    var body = jsonEncode(
        {'username': username, 'id_produk': idProduk, 'status': status});
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
    await getUsername().then((value) {
      _username = value;
    });
    try {
      var uri = Uri.parse("$url/penjual/create_produk");
      var request = new client.MultipartRequest("POST", uri);
      request.headers['authorization'] = _token;

      request.fields['username'] = _username;
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
    await getUsername().then((value) {
      _username = value;
    });
    try {
      var uri = Uri.parse("$url/penjual/update_produk");
      var request = new client.MultipartRequest("POST", uri);
      request.headers['authorization'] = _token;

      request.fields['username'] = _username;
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
              print(response.body);
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
}
