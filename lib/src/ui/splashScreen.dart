
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toast/toast.dart';
import 'package:tumbaso_warung/src/pref/preferences.dart';
import 'package:tumbaso_warung/src/ui/utils/colorses.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _token;
  _authCheckSession() async {
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
  void initState() {
    _authCheckSession();
    getToken().then((value){
      if(mounted)
        setState(() {
          _token= value;
        });
    });
    Timer(Duration(seconds: 2), () {
      _token==null?Navigator.pushReplacementNamed(context, '/login'):Navigator.pushReplacementNamed(context, '/controllerPage');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: colorses.dasar,
        child: Center(
          child: Container(
            width: 200,
            height: 200,
            child: SvgPicture.asset(
                "assets/warung.svg",
                semanticsLabel: 'Acme Logo'
            ),
          ),
        ),
      ),
    );
  }
}
