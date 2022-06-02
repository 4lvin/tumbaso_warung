import 'package:flutter/material.dart';
import 'package:tumbaso_warung/src/ui/historyBarang.dart';
import 'package:tumbaso_warung/src/ui/historyMaem.dart';
import 'package:tumbaso_warung/src/ui/utils/colorses.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({this.selected});
  int? selected;
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>{

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
        title: new Text("Riwayat"),
      ),
      body: new HistoryMaem(),
    );
  }
}
