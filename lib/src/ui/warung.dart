import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'package:tumbaso_warung/src/bloc/memberBloc.dart';
import 'package:tumbaso_warung/src/models/getSetoranModel.dart';
import 'package:tumbaso_warung/src/pref/preferences.dart';
import 'package:tumbaso_warung/src/ui/utils/colorses.dart';

class WarungPage extends StatefulWidget {
  @override
  _WarungPageState createState() => _WarungPageState();
}

class _WarungPageState extends State<WarungPage> {
  final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
  bool onOff = false;
  String nama;
  String token;
  String username;
  String _image() {
    String link = "assets/close.png";
    if (onOff == false) {
      link = "assets/open.png";
    }
    return link;
  }

  Color _open() {
    Color link = Colors.black;
    if (!onOff) {
      link = Colors.green;
    }
    return link;
  }

  Color _close() {
    Color link = Colors.black;
    print(onOff);
    if (onOff == false) {
      link = Colors.black;
    } else {
      link = Colors.red;
    }
    return link;
  }

  getSetoran() {
    getKdUser().then((kduser) {
      blocMember.getSetoranProduct(kduser);
    });
  }

  @override
  void initState() {
    getToken().then((value) {
      if (mounted)
        setState(() {
          token = value;
        });
    });
    getUsername().then((value) {
      if (mounted)
        setState(() {
          username = value;
        });
    });
    getKdUser().then((value) async {
      await blocMember.status(value);
      await blocMember.getSetoranProduct(value);
    });
    blocMember.getStatus.listen((event) {
      if (mounted)
        setState(() {
          nama = event.data[0].nama;
        });
      if (event.data[0].aktif == "1") {
        if (mounted)
          setState(() {
            onOff = false;
          });
      } else {
        if (mounted)
          setState(() {
            onOff = true;
          });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: InkWell(
                onTap: () {
                  rmvUsername();
                  rmvKdUser();
                  rmvNama();
                  rmvToken();
                  Navigator.pushReplacementNamed(context, "/login");
                },
                child: Icon(
                  Icons.exit_to_app,
                  color: Colors.red,
                )),
          )
        ],
      ),
      body: nama == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: <Widget>[
                Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                    child: Text(
                      "Hallo $nama !",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: colorses.dasar),
                    )),
                SizedBox(height: 10),
                Container(
                  width: 180,
                  height: 180,
                  child: Image.asset(
                    _image(),
                    color: onOff ? Colors.red : Colors.green,
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        blocMember.updateStatusToko(username, "1", token);
                        blocMember.resStatusToko.listen((event) {
                          if (event.status) {
                            setState(() {
                              onOff = false;
                            });
                          }
                        });
                      },
                      child: Text(
                        'Buka',
                        style: TextStyle(fontSize: 30, color: _open()),
                      ),
                    ),
                    Switch(
                        activeColor: colorses.dasar,
                        inactiveTrackColor: colorses.kuning,
                        value: onOff,
                        onChanged: (newValue) {
                          onOff = newValue;
                          if (newValue) {
                            blocMember.updateStatusToko(username, "0", token);
                            blocMember.resStatusToko.listen((event) {
                              if (event.status) {
                                Toast.show("Toko berhasil di Tutup", context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.BOTTOM);
                              }
                            });
                          } else {
                            blocMember.updateStatusToko(username, "1", token);
                            blocMember.resStatusToko.listen((event) {
                              if (event.status) {
                                Toast.show("Toko berhasil di Buka", context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.BOTTOM);
                              }
                            });
                          }
                          setState(() {});
                        }),
                    GestureDetector(
                      onTap: () {
                        blocMember.updateStatusToko(username, "0", token);
                        blocMember.resStatusToko.listen((event) {
                          if (event.status) {
                            setState(() {
                              onOff = true;
                            });
                          }
                        });
                      },
                      child: Text(
                        'Tutup',
                        style: TextStyle(fontSize: 30, color: _close()),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: StreamBuilder(
                      stream: blocMember.listSetoran,
                      builder:
                          (context, AsyncSnapshot<GetSetoranModel> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.data.length,
                              itemBuilder: (BuildContext context, int i) {
                                return Card(
                                  elevation: 5.0,
                                  shadowColor: Colors.green,
                                  color: Colors.green[50],
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Column(
                                          children: [
                                            Text('Setoran',
                                                style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            SizedBox(height: 5),
                                            Text(
                                                formatCurrency.format(snapshot
                                                    .data.data[i].setorPenjual),
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                Text('Tunggakan',
                                                    style: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                                SizedBox(height: 5),
                                                Text(
                                                    formatCurrency.format(
                                                        snapshot.data.data[i]
                                                            .tunggakanSetor),
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.refresh,
                                              ),
                                              color: Colors.green,
                                              splashColor: Colors.greenAccent,
                                              onPressed: () async {
                                                getSetoran();
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error);
                        } else {
                          return SizedBox();
                        }
                      }),
                ),
              ],
            ),
    );
  }
}
