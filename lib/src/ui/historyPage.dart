import 'package:flutter/material.dart';
import 'package:tumbaso_warung/src/ui/historyBarang.dart';
import 'package:tumbaso_warung/src/ui/historyMaem.dart';
import 'package:tumbaso_warung/src/ui/utils/colorses.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({this.selected});
  int selected;
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
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
        title: new Text("Riwayat"),
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
          new HistoryMaem(),
          new HistoryBarang(),
        ],
      ),
    );
  }
}
