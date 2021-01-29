
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as client;
import 'package:tumbaso_warung/src/models/getProdukModel.dart';
import 'package:tumbaso_warung/src/models/getStatusModel.dart';

import 'dart:io';

import 'package:tumbaso_warung/src/models/resLoginModel.dart';
import 'package:tumbaso_warung/src/models/resUpdateStatusTokoModel.dart';

class ApiProviders {
  String url = "https://jongjava.tech/tumbas/restapi";

  Future login(String username, String password) async {
    var body = jsonEncode({'username': username, 'password': password, "token":""});
    try {
      final checkid =  await client .post("$url/penjual/login",
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
      final checkid =  await client .post("$url/penjual/get_penjual",
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

  Future updateStatusToko(String username,String status,String token) async {
    var body = jsonEncode({'username': username,'status':status});
    try {
      final checkid =  await client .post("$url/penjual/put_status_toko",
          headers: {"Content-Type": "application/json", "Authorization": token}, body: body)
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

  Future getProduk(String username,String idPenjual,String token) async {
    var body = jsonEncode({'penjual_id': idPenjual,'username':username});
    try {
      final checkid =  await client .post("$url/penjual/get_produk_penjual",
          headers: {"Content-Type": "application/json", "Authorization": token}, body: body)
          .timeout(const Duration(seconds: 11));
      print(checkid.body);
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
}