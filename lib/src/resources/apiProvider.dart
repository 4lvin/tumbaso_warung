
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as client;

import 'dart:io';

import 'package:tumbaso_warung/src/models/login.dart';

class ApiProviders {
  String url = "https://jongjava.tech/tumbas/restapi";

  Future login(String username, String password) async {
    print("username");
    print(username);
    print('password');
    print(password);
    print("username2");
    var body = jsonEncode({'username': username, 'password': password, "token":""});
    try {
      final checkid =  await client .post("$url/penjual/login",
          headers: {"Content-Type": "application/json"}, body: body)
          .timeout(const Duration(seconds: 11));
      if (checkid.statusCode == 200) {
        return Login.fromJson(json.decode(checkid.body));
      } else if (checkid.statusCode == 404) {
        return Login.fromJson(json.decode(checkid.body));
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