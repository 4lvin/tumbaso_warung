import 'package:flutter/material.dart';
import 'package:tumbaso_warung/src/ui/controllerPage.dart';
import 'package:tumbaso_warung/src/ui/lengkapiProfil.dart';
import 'package:tumbaso_warung/src/ui/login.dart';
import 'package:tumbaso_warung/src/ui/splashScreen.dart';
import 'package:tumbaso_warung/src/ui/utils/colorses.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color(0xff68A29D)),
      home: Scaffold(
        body: SplashScreen(),
      ),
      routes: <String, WidgetBuilder>{
        '/controllerPage': (BuildContext context) => new ControllerPage(),
        '/login': (BuildContext context) => new LoginPage(),
        '/lengkapiProfil': (BuildContext context) => new LengkapiProfil(),
      },
    );
  }
}
