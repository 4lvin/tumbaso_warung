
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:tumbaso_warung/src/pref/preferences.dart';
import 'package:tumbaso_warung/src/ui/utils/colorses.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _token;
  _authCheckSession(String id, String token) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      Toast.show("Cek Internet Anda", context,
          duration: 7, gravity: Toast.BOTTOM);
    }
  }
  @override
  void initState(){
    getToken().then((value){
      setState(() {
        _token= value;
      });
    });
    Timer(Duration(seconds: 2), () {
      _token==null?Navigator.pushReplacementNamed(context, '/login'):Navigator.pushReplacementNamed(context, '/controllerPage');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: colorses.background,
        child: Center(
          child: Container(
            width: 300,
            height: 300,
            child: Image.asset("assets/iconw.png"),
          ),
        ),
      ),
    );
  }
}
