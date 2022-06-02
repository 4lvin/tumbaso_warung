import 'package:flutter/material.dart';
import 'package:tumbaso_warung/src/ui/transaksiBarang.dart';
import 'package:tumbaso_warung/src/ui/transaksiMaem.dart';
import 'package:tumbaso_warung/src/ui/utils/colorses.dart';

class TransaksiPage extends StatefulWidget {
  TransaksiPage({this.selected});
  int? selected;
  @override
  _TransaksiPageState createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage>{

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: colorses.dasar,
        title: new Text("Transaksi"),
      ),
      body: new TransaksiMaem(),
    );
  }
}
