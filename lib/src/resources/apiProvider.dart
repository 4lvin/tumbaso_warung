import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as client;
import 'package:tumbaso_warung/src/models/getProdukModel.dart';
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

  Future uploadFile(File file) async {
    try {
      FileUploadModel data;
      var uri = Uri.parse("$url/umum/upload?tipe=foto_produk");
      var request = new client.MultipartRequest("POST", uri);
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
      await request
          .send()
          .then((result) async {
            await client.Response.fromStream(result).then((response) {
              if (response.statusCode == 200) {
                data = FileUploadModel.fromJson(json.decode(response.body));
              } else {
                return new FileUploadModel();
              }
            });
          })
          .catchError((err) => print('error : ' + err.toString()))
          .whenComplete(() {});
      return data.foto;
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
      print(checkid.body);
      print(body);
      print(token);
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
      String kategori,
      String subkategori,
      String nama,
      String harga,
      String berat,
      String deskripsi,
      String potongan,
      String gambar_1) async {
    String _token;
    String _username;
    await getToken().then((value) {
      _token = value;
    });
    await getUsername().then((value) {
      _username = value;
    });

    var body = jsonEncode({
      'username': _username,
      'kategori_id': kategori,
      'subkategori_id': subkategori,
      'nama_produk': nama,
      'harga_pokok': harga,
      'potongan': potongan,
      'berat': berat,
      'deskripsi': deskripsi,
      'aktif': 1,
      'utama': 0,
      'gambar_1': gambar_1
    });
    try {
      final produk = await client
          .post("$url/penjual/create_produk",
              headers: {
                "Content-Type": "application/json",
                "Authorization": "$_token"
              },
              body: body)
          .timeout(const Duration(seconds: 11));
      if (produk.statusCode == 200) {
        return produk.statusCode;
      } else {
        throw Exception('Failure response');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }
}
