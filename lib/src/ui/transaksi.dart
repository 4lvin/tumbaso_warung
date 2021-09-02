import 'package:flutter/material.dart';
import 'package:tumbaso_warung/src/ui/transaksiBarang.dart';
import 'package:tumbaso_warung/src/ui/transaksiMaem.dart';
import 'package:tumbaso_warung/src/ui/utils/colorses.dart';

class TransaksiPage extends StatefulWidget {
  TransaksiPage({this.selected});
  int selected;
  @override
  _TransaksiPageState createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = new TabController(
        length: 2,
        vsync: this,
        initialIndex: widget.selected == null ? 0 : widget.selected);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: colorses.dasar,
        title: new Text("Transaksi"),
        bottom: new TabBar(
          controller: controller,
          indicatorColor: Colors.white,
          labelStyle: TextStyle(fontSize: 20),
          tabs: <Widget>[
            new Tab(
              text: "Makanan",
            ),
            new Tab(
              text: "Barang",
            )
          ],
        ),
      ),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new TransaksiMaem(),
          new TransaksiBarang(),
        ],
      ),
    );
  }
}
