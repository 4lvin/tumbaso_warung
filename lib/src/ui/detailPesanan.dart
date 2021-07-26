import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'package:tumbaso_warung/src/models/getTransaksiModel.dart';
import 'package:tumbaso_warung/src/pref/preferences.dart';
import 'package:tumbaso_warung/src/ui/utils/colorses.dart';

class DetailPesanan extends StatefulWidget {
  DetailPesanan({this.pesanan});

  Datum pesanan;

  @override
  _DetailPesananState createState() => _DetailPesananState();
}

class _DetailPesananState extends State<DetailPesanan> {
  final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
  final String _baseImage = "http://jongjava.tech/tumbas/assets/foto_produk/";
  // final String _baseImage = "https://tumbasonline.com/assets/foto_produk/";
  String token;
  String username;

  @override
  void initState() {
    getToken().then((value) {
      setState(() {
        token = value;
      });
    });
    getUsername().then((value) {
      setState(() {
        username = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Pesanan"),
        backgroundColor: colorses.dasar,
      ),
      body: SafeArea(
        child: new Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.grey[200],
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text("Kode Transaksi : "),
                    ),
                    Text(widget.pesanan.kodeTransaksi),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text("Status Pesanan"),
                    Container(
                      // width: 200,
                      margin: EdgeInsets.only(top: 12, bottom: 12),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: setColorStatus(
                              widget.pesanan.status.idStatusPesanan)),
                      child: Text(widget.pesanan.status.namaStatusPesanan,
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text("Nama Kurir"),
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 12, bottom: 12),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: colorses.background),
                          child: Text(widget.pesanan.detailPengiriman.kurir,
                              style: TextStyle(color: Colors.black)),
                        ),
                        Container(
                            height: 85,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.black45,
                                image: DecorationImage(
                                    image: NetworkImage(_baseImage +
                                        widget.pesanan.detailPengiriman.foto),
                                    fit: BoxFit.cover)))
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  color: colorses.kuning,
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Container(
                          width: MediaQuery.of(context).size.width / 3 + 10,
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Text("Pesanan",
                              style: TextStyle(fontSize: 15.0))),
                      Container(width: 50, child: Center(child: Text("Qty"))),
                      Container(
                        width: MediaQuery.of(context).size.width / 3 - 30,
                        child: Center(
                          child: Text("Harga",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 14.0)),
                        ),
                      ),
                    ],
                  ),
                ),
                for (int i = 0; i < widget.pesanan.produk.length; i++)
                  Container(
                      // height: 110.0,
                      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 1),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[300],
                            width: 1.0,
                          ),
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.white, spreadRadius: 1),
                        ],
                      ),
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.only(
                            left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
                        title: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  width: MediaQuery.of(context).size.width / 3 +
                                      10,
                                  child: Text(
                                      widget.pesanan.produk[i].namaProduk,
                                      style: TextStyle(fontSize: 14.0))),
                              Container(
                                  width: 50,
                                  child: Center(
                                      child:
                                          Text(widget.pesanan.produk[i].qty))),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 3 - 30,
                                child: Center(
                                  child: Text(
                                      formatCurrency.format(
                                          widget.pesanan.produk[i].harga),
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 14.0)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  margin: EdgeInsets.only(top: 12),
                  height: 40,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Metode Pembayaran"),
                      Container(
                          padding: EdgeInsets.only(
                              top: 3, bottom: 3, left: 15, right: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: colorses.dasar),
                          child: Text(
                            "Cash",
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text("Ringkasan Pembayaran",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 45,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey[200],
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Total Pembayaran"),
                            Text(
                                formatCurrency
                                    .format(widget.pesanan.totalHarga),
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  setColorStatus(statusId) {
    Color status;
    switch (statusId) {
      case '3':
      case '4':
        status = Colors.blue;
        break;
      case '5':
        status = Colors.yellow[900];
        break;
      case '6':
        status = Colors.green;
        break;
      case '7':
      case '8':
        status = Colors.red;
        break;
      default:
    }
    return status;
  }
}
