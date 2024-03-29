import 'dart:async';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toast/toast.dart';
import 'package:tumbaso_warung/src/pref/preferences.dart';
import 'package:tumbaso_warung/src/ui/controllerPage.dart';
import 'package:tumbaso_warung/src/ui/utils/colorses.dart';
import 'package:tumbaso_warung/src/ui/utils/notification.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? _token;

  _authCheckSession() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      Toast.show("Cek Internet Anda", duration: 7, gravity: Toast.bottom);
    }
  }

  @override
  void initState() {
    _authCheckSession();
    getToken().then((value) {
      if (mounted)
        setState(() {
          _token = value;
        });
    });
    messaging();

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Izinkan Notifikasi'),
            content: Text('Aplikasi membutuhkan akses notifikasi'),
            actions: [
              TextButton(
                onPressed: () => nav(),
                child: Text(
                  'Jangan Izinkan',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              TextButton(
                onPressed: () => AwesomeNotifications().requestPermissionToSendNotifications().then((_) => nav()),
                child: Text('Izinkan'),
              ),
            ],
          ),
        );
      } else {
        Timer(Duration(seconds: 2), () {
          nav();
        });
      }
    });
    _onActionNotif();
    super.initState();
  }

  _onActionNotif() {
    AwesomeNotifications().displayedStream.listen((event) {
      if (event.channelKey == 'barang_channel') {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            settings: const RouteSettings(name: '/controllerPage'),
            builder: (context) => new ControllerPage(
                  selected: 1,
                )));
        // _selectedTransakasi = true;
        // _selectedIndex = 1;
        // setState(() {});
      } else if (event.channelKey == 'maem_channel') {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            settings: const RouteSettings(name: '/controllerPage'),
            builder: (context) => new ControllerPage(
              selected: 1,
            )));
        // _selectedTransakasi = false;
        // _selectedIndex = 1;
        // setState(() {});
      } else {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            settings: const RouteSettings(name: '/controllerPage'),
            builder: (context) => new ControllerPage(
              selected: 0,
            )));
        // _selectedTransakasi = false;
        // _selectedIndex = 0;
        // setState(() {});
      }
    });

    AwesomeNotifications().actionStream.listen((event) {
      if (event.channelKey == 'barang_channel') {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            settings: const RouteSettings(name: '/controllerPage'),
            builder: (context) => new ControllerPage(
              selected: 1,
            )));
        // _selectedTransakasi = true;
        // _selectedIndex = 1;
        // setState(() {});
      } else if (event.channelKey == 'maem_channel') {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            settings: const RouteSettings(name: '/controllerPage'),
            builder: (context) => new ControllerPage(
              selected: 1,
            )));
        // _selectedTransakasi = false;
        // _selectedIndex = 1;
        // setState(() {});
      } else {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            settings: const RouteSettings(name: '/controllerPage'),
            builder: (context) => new ControllerPage(
              selected: 0,
            )));
        // _selectedTransakasi = false;
        // _selectedIndex = 0;
        // setState(() {});
      }
    });
  }

  @override
  void dispose() {
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().displayedSink.close();
    AwesomeNotifications().createdSink.close();
    super.dispose();
  }

  messaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.data != null) {
        CustomNotification().typeNotif(message);
      }
    });
  }

  nav() {
    _token == null
        ? Navigator.pushReplacementNamed(context, '/login')
        : Navigator.pushReplacementNamed(context, '/controllerPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: colorses.dasar,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2 - 100),
                width: 200,
                height: 200,
                child: SvgPicture.asset("assets/warung.svg", semanticsLabel: 'Tumbas'),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
            ),
            Text(
              "Bekerjasama dengan :",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 50,
              height: 50,
              child: SvgPicture.asset("assets/pasmak.svg", semanticsLabel: 'pasmak'),
            ),
          ],
        ),
      ),
    );
  }
}
