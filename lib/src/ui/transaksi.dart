import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tumbaso_warung/src/bloc/memberBloc.dart';
import 'package:tumbaso_warung/src/models/getTransaksiModel.dart';
import 'package:tumbaso_warung/src/pref/preferences.dart';
import 'package:tumbaso_warung/src/ui/detailPesanan.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tumbaso_warung/src/ui/utils/colorses.dart';

class TransaksiPage extends StatefulWidget {
  @override
  _TransaksiPageState createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = new TabController(length: 2, vsync: this);
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
        title: new Text("Pesanan"),
        bottom: new TabBar(
          controller: controller,
          indicatorColor: Colors.cyan[400],
          tabs: <Widget>[
            new Tab(
              icon: new Icon(Icons.autorenew),
              text: "Aktif",
            ),
            new Tab(
              icon: new Icon(Icons.check_circle),
              text: "Selesai",
            )
          ],
        ),
      ),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new TransactionDetail(history: '0'),
          new TransactionDetail(history: '1'),
        ],
      ),
    );
  }
}

class TransactionDetail extends StatefulWidget {
  final String history;

  const TransactionDetail({Key key, this.history}) : super(key: key);

  @override
  _TransactionDetailState createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetail> {
  final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
  final String _baseImage = "http://jongjava.tech/tumbas/assets/foto_produk/";
  // final String _baseImage = "https://tumbasonline.com/assets/foto_produk/";

  @override
  void initState() {
    print(widget.history);
    getUsername().then((value) {
      blocMember.getTransaksi(value, widget.history);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder(
              stream: blocMember.listTransaksi,
              builder: (context, AsyncSnapshot<GetTransaksiModel> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.data.length,
                      itemBuilder: (BuildContext context, int i) {
                        return SafeArea(
                            child: Column(children: <Widget>[
                          Container(
                            height: 110.0,
                            margin: EdgeInsets.only(bottom: 1),
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
                                  left: 10.0,
                                  right: 10.0,
                                  top: 10.0,
                                  bottom: 10.0),
                              title: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 30.0,
                                      backgroundImage: NetworkImage(
                                        _baseImage +
                                            snapshot
                                                .data.data[i].produk[0].gambar1,
                                        // _baseImage +
                                        //     snapshot
                                        //         .data.data[i].produk[0].gambar1,
                                      ),
                                      backgroundColor: Colors.transparent,
                                    ),
                                    SizedBox(width: 5.0),
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                                width: 120,
                                                child: Text(
                                                    snapshot
                                                        .data
                                                        .data[i]
                                                        .pelanggan
                                                        .namaPelanggan,
                                                    style: TextStyle(
                                                        fontSize: 16.0))),
                                            Text(
                                                formatCurrency.format(snapshot
                                                    .data.data[i].totalHarga),
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 14.0)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // width: 100,
                                      height: 30,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          color: setColorStatus(snapshot.data
                                              .data[i].status.idStatusPesanan)),
                                      child: Center(
                                        child: Text(
                                          snapshot.data.data[i].status
                                              .namaStatusPesanan,
                                          style: TextStyle(color: Colors.white),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        duration: Duration(milliseconds: 200),
                                        child: DetailPesanan(
                                          pesanan: snapshot.data.data[i],
                                        )));
                              },
                            ),
                          ),
                        ]));
                      });
                } else if (snapshot.hasError) {
                  return Text(snapshot.error);
                } else {
                  return Center(
                    child: new CircularProgressIndicator(
                      backgroundColor: Colors.blueGrey,
                    ),
                  );
                }
              }),
        ),
      ],
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
