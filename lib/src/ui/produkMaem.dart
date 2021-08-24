import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toast/toast.dart';
import 'package:tumbaso_warung/src/bloc/memberBloc.dart';
import 'package:tumbaso_warung/src/models/getProdukModel.dart';
import 'package:tumbaso_warung/src/pref/preferences.dart';
import 'package:tumbaso_warung/src/ui/editProduct.dart';
import 'package:tumbaso_warung/src/ui/newProduct.dart';
import 'package:tumbaso_warung/src/ui/utils/colorses.dart';

class ProdukMaem extends StatefulWidget {
  @override
  _ProdukMaemState createState() => _ProdukMaemState();
}

class _ProdukMaemState extends State<ProdukMaem> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  List<bool> onOff = [];
  String status;
  bool onOffw = false;
  String nama;
  String token;
  String username;

  String _image() {
    String link = "assets/close.png";
    if (onOffw == false) {
      link = "assets/open.png";
    }
    return link;
  }

  Color _open() {
    Color link = Colors.black;
    if (!onOffw) {
      link = Colors.green;
    }
    return link;
  }

  Color _close() {
    Color link = Colors.black;
    if (onOffw == false) {
      link = Colors.black;
    } else {
      link = Colors.red;
    }
    return link;
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    getToken().then((token) {
      getEmail().then((username) {
        getKdUser().then((kduser) {
          blocMember.status(kduser);
          blocMember.getProduk(username, kduser, token);
          if (mounted)
            setState(() {
              username = username;
              token = token;
            });
        });
      });
    });
    blocMember.getStatus.listen((event) {
      if (event.data[0].aktif == "1") {
        if (mounted)
          setState(() {
            status = "ada";
          });
      } else {
        if (mounted)
          setState(() {
            status = "habis";
          });
      }
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    getToken().then((token) {
      getEmail().then((username) {
        getKdUser().then((kduser) {
          blocMember.status(kduser);
          blocMember.getProduk(username, kduser, token);
          if (mounted)
            setState(() {
              username = username;
              token = token;
            });
        });
      });
    });
    blocMember.getStatus.listen((event) {
      if (event.data[0].aktif == "1") {
        if (mounted)
          setState(() {
            status = "ada";
            onOffw = false;
          });
      } else {
        if (mounted)
          setState(() {
            status = "habis";
            onOffw = true;
          });
      }
    });
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    getToken().then((token) {
      getEmail().then((username) {
        if(mounted)
          setState(() {
            username = username;
            token = token;
          });
        getKdUser().then((kduser) {
          blocMember.status(kduser);
          blocMember.getProduk(username, kduser, token);
        });
      });
    });
    blocMember.getStatus.listen((event) {
      if (event.data[0].aktif == "1") {
        if (mounted)
          setState(() {
            status = "ada";
          });
      } else {
        if (mounted)
          setState(() {
            status = "habis";
          });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Produk Makanan"),
          backgroundColor: colorses.dasar,
        ),
        body: Column(
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              child: Image.asset(
                _image(),
                color: onOffw ? Colors.red : Colors.green,
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
                          onOffw = false;
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
                    inactiveTrackColor: colorses.orange,
                    value: onOffw,
                    onChanged: (newValue) {
                      onOffw = newValue;
                      if (newValue) {
                        blocMember.updateStatusToko(username, "0", token);
                        blocMember.resStatusToko.listen((event) {
                          if (event.status) {
                            Toast.show("Toko berhasil di Tutup", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                          }
                        });
                      } else {
                        blocMember.updateStatusToko(username, "1", token);
                        blocMember.resStatusToko.listen((event) {
                          if (event.status) {
                            Toast.show("Toko berhasil di Buka", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
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
                          onOffw = true;
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
                  stream: blocMember.listProduk,
                  builder: (context, AsyncSnapshot<GetProdukModel> snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data.data.isNotEmpty
                          ? SmartRefresher(
                              enablePullDown: true,
                              enablePullUp: false,
                              header: WaterDropMaterialHeader(),
                              controller: _refreshController,
                              onRefresh: _onRefresh,
                              onLoading: _onLoading,
                              child: ListView.builder(
                                  // physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.data.length,
                                  itemBuilder: (BuildContext context, int i) {
                                    // var formatDate = DateFormat('d MMM yyyy').format(snapshot.data.data[i].waktu);
                                    // var formatTime = DateFormat().add_jm().format(snapshot.data.data[i].waktu);
                                    if (snapshot.data.data[i].aktif == "1") {
                                      onOff.add(false);
                                    } else {
                                      onOff.add(true);
                                    }
                                    return Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.white, border: Border(bottom: BorderSide(color: Colors.grey[200]))),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => EditProductPage(produk: snapshot.data.data[i])));
                                              // Navigator.push(
                                              //     context,
                                              //     PageTransition(
                                              //         type: PageTransitionType.rightToLeft,
                                              //         inheritTheme: true,
                                              //         ctx: context,
                                              //         duration: Duration(milliseconds: 400),
                                              //         child: DetailPesanan(pesanan: snapshot.data.data[i],)));
                                            },
                                            child: ListTile(
                                              leading: Stack(
                                                children: <Widget>[
                                                  Container(
                                                    // margin: EdgeInsets.only(top: 5),
                                                    width: 80,
                                                    height: 120,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                              "http://jongjava.tech/tumbas/assets/foto_produk/" +
                                                                  snapshot.data.data[i].gambar.gambar1,
                                                            ),
                                                            // image: NetworkImage(
                                                            //     "https://tumbasonline.com/assets/foto_produk/" +
                                                            //         snapshot
                                                            //             .data
                                                            //             .data[i]
                                                            //             .gambar
                                                            //             .gambar1,
                                                            //     ),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                  snapshot.data.data[i].aktif == "0"
                                                      ? Container(
                                                          // margin: EdgeInsets.only(top: 5),
                                                          width: 80,
                                                          height: 120,
                                                          color: Colors.white54,
                                                          child: Center(
                                                              child: Text(
                                                            "Habis",
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold, color: Colors.red, fontSize: 18),
                                                          )),
                                                        )
                                                      : Container(
                                                          height: 50,
                                                          width: 50,
                                                        )
                                                ],
                                              ),
                                              title: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    snapshot.data.data[i].namaProduk,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold,
                                                        color: status == "habis" || snapshot.data.data[i].aktif == "0"
                                                            ? Colors.grey
                                                            : Colors.black),
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    "Rp. " + snapshot.data.data[i].hargaJual,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: status == "habis" || snapshot.data.data[i].aktif == "0"
                                                            ? Colors.grey
                                                            : Colors.black),
                                                  )
                                                  // Text(
                                                  //   formatDate,
                                                  //   overflow: TextOverflow.ellipsis,
                                                  //   maxLines: 2,
                                                  //   style: TextStyle(fontSize: 12),
                                                  // ),
                                                ],
                                              ),
                                              trailing: Switch(
                                                  activeColor: colorses.dasar,
                                                  inactiveTrackColor: colorses.orange,
                                                  value: onOff[i],
                                                  onChanged: (newValue) {
                                                    onOff[i] = newValue;
                                                    if (newValue) {
                                                      getEmail().then((user) {
                                                        getToken().then((token) {
                                                          blocMember.updateStatusProduk(
                                                              user, snapshot.data.data[i].idProduk, "0", token);
                                                        });
                                                      });
                                                      blocMember.resUpdateStatusProduk.listen((event) {
                                                        if (event.status) {
                                                          getToken().then((token) {
                                                            getEmail().then((username) {
                                                              getKdUser().then((kduser) {
                                                                blocMember.status(kduser);
                                                                blocMember.getProduk(username, kduser, token);
                                                              });
                                                            });
                                                          });
                                                          Toast.show("Produk di set habis!", context,
                                                              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                                                        }
                                                      });
                                                    } else {
                                                      getEmail().then((user) {
                                                        getToken().then((token) {
                                                          blocMember.updateStatusProduk(
                                                              user, snapshot.data.data[i].idProduk, "1", token);
                                                        });
                                                      });
                                                      blocMember.resUpdateStatusProduk.listen((event) {
                                                        if (event.status) {
                                                          getToken().then((token) {
                                                            getEmail().then((username) {
                                                              getKdUser().then((kduser) {
                                                                blocMember.status(kduser);
                                                                blocMember.getProduk(username, kduser, token);
                                                              });
                                                            });
                                                          });
                                                          Toast.show("Produk di set ada!", context,
                                                              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                                                        }
                                                      });
                                                    }
                                                    setState(() {});
                                                  }),
                                            ),
                                          ),
//                              Divider(),
                                        ],
                                      ),
                                    );
                                  }),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.notifications_off,
                                      color: Colors.grey,
                                      size: 50,
                                    ),
                                    Text(
                                      "Belum mempunyai produk",
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ),
                              ),
                            );
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
        ),
        floatingActionButton: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewProductPage()),
            );
          },
          child: new Container(
            width: 150,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: colorses.dasar
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/dinner.png",color: Colors.black, width: 20, height: 20,),
                Text("Tambah menu",style: TextStyle(color: Colors.white),)
              ],
            ),
          ),
        ));
  }
}
