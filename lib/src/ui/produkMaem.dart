import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toast/toast.dart';
import 'package:tumbaso_warung/src/bloc/memberBloc.dart';
import 'package:tumbaso_warung/src/models/getProdukModel.dart';
import 'package:tumbaso_warung/src/pref/preferences.dart';
import 'package:tumbaso_warung/src/resources/globalApi.dart';
import 'package:tumbaso_warung/src/ui/editProduct.dart';
import 'package:tumbaso_warung/src/ui/newProduct.dart';
import 'package:tumbaso_warung/src/ui/utils/colorses.dart';

class ProdukMaem extends StatefulWidget {
  @override
  _ProdukMaemState createState() => _ProdukMaemState();
}

class _ProdukMaemState extends State<ProdukMaem> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<bool> onOff = [];
  String? status;
  bool onOffw = false;
  String? nama;
  String? token;
  String? username;

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
      if (event.data?[0].aktif == "1") {
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
      if (event.data?[0].aktif == "1") {
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
      getEmail().then((email) {
        if (mounted)
          setState(() {
            username = email;
            token = token;
          });
        getKdUser().then((kduser) {
          blocMember.status(kduser);
          blocMember.getProduk(email, kduser, token);
        });
      });
    });
    blocMember.getStatus.listen((event) {
      if (event.data?[0].aktif == "1") {
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
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Produk Makanan"),
          backgroundColor: colorses.dasar,
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 110,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: colorses.dasar, width: 1.5)),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        child: Image.asset(
                          _image(),
                          color: onOffw ? Colors.red : Colors.green,
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 12),
                          width: MediaQuery.of(context).size.width - 130,
                          child: Text(
                            "Warung anda sekarang buka, apakah anda ingin menutup warung?",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      if (onOffw) {
                        blocMember.updateStatusToko(username!, "1", token!);
                        blocMember.resStatusToko.listen((event) {
                          if (event.status!) {
                            setState(() {
                              onOffw = false;
                            });
                          }
                        });
                      } else {
                        blocMember.updateStatusToko(username!, "0", token!);
                        blocMember.resStatusToko.listen((event) {
                          if (event.status!) {
                            setState(() {
                              onOffw = true;
                            });
                          }
                        });
                      }
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width - 50,
                        child: Text(
                          "${onOffw ? "Buka Sekarang" : "Tutup Sekarang"}",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: colorses.orange),
                        )),
                  )
                ],
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: StreamBuilder(
                  stream: blocMember.listProduk,
                  builder: (context, AsyncSnapshot<GetProdukModel> snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!.data!.isNotEmpty
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
                                  itemCount: snapshot.data!.data!.length,
                                  itemBuilder: (BuildContext context, int i) {
                                    // var formatDate = DateFormat('d MMM yyyy').format(snapshot.data.data[i].waktu);
                                    // var formatTime = DateFormat().add_jm().format(snapshot.data.data[i].waktu);
                                    if (snapshot.data!.data?[i].aktif == "1") {
                                      onOff.add(false);
                                    } else {
                                      onOff.add(true);
                                    }
                                    return buildItems(
                                        size, snapshot.data!.data![i]);
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
                      return Text(snapshot.error.toString());
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
                borderRadius: BorderRadius.circular(25), color: colorses.dasar),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/dinner.png",
                  width: 28,
                  height: 28,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Tambah menu",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget buildItems(Size size, Datum makanan) {
    return Container(
      width: size.width,
      height: size.height * 0.12,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black12,
          ),
        ),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              // Container(
              //   width: 80,
              //   height: 80,
              //   margin: EdgeInsets.only(right: 10),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     image: DecorationImage(
              //       fit: BoxFit.cover,
              //       image: '${globalMaem}/assets/foto_produk/${makanan.gambar.gambar1}' !=
              //               '${globalMaem}/assets/foto_produk/no_image.png'
              //           ? NetworkImage(
              //               '${globalMaem}/assets/foto_produk/${makanan.gambar.gambar1}')
              //           : AssetImage('assets/baru2.png'),
              //     ),
              //   ),
              // ),
              makanan.aktif == "0"
                  ? Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 80,
                        height: 81,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white60),
                        child: Center(
                            child: Text(
                          "Habis",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
                      ),
                    )
                  : Container()
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      makanan.namaProduk??"",
                      style: TextStyle(
                          fontSize: 16,
                          color: makanan.aktif == "1"
                              ? Colors.black
                              : Colors.grey),
                    ),
                    Text(
                      makanan.deskripsi??"",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                Text(
                  'Rp. ${makanan.hargaJual}',
                  style: TextStyle(
                      fontSize: 16,
                      color: makanan.aktif == "1" ? Colors.black : Colors.grey),
                ),
              ],
            ),
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: PopupMenuButton<int>(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.more_vert, color: Colors.grey, size: 20),
                  onSelected: (item) => handleClick(item, makanan),
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(value: 0, child: Text('Edit')),
                    PopupMenuItem<int>(value: 1, child: Text('Hapus')),
                  ],
                ),
              ),
              Container(
                width: 85,
                height: 25,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      makanan.aktif == '0'
                          ? Color(0xFF68A29D)
                          : colorses.orange,
                    ),
                    elevation: MaterialStateProperty.all(2),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (makanan.aktif == "1") {
                      getEmail().then((user) {
                        getToken().then((token) {
                          blocMember.updateStatusProduk(
                              user, makanan.idProduk!, "0", token);
                        });
                      });
                      blocMember.resUpdateStatusProduk.listen((event) {
                        if (event.status!) {
                          getToken().then((token) {
                            getEmail().then((username) {
                              getKdUser().then((kduser) {
                                blocMember.status(kduser);
                                blocMember.getProduk(username, kduser, token);
                              });
                            });
                          });
                          Toast.show("Produk di set habis!",
                              duration: Toast.lengthLong,
                              gravity: Toast.bottom);
                        }
                      });
                    } else {
                      getEmail().then((user) {
                        getToken().then((token) {
                          blocMember.updateStatusProduk(
                              user, makanan.idProduk!, "1", token);
                        });
                      });
                      blocMember.resUpdateStatusProduk.listen((event) {
                        if (event.status!) {
                          getToken().then((token) {
                            getEmail().then((username) {
                              getKdUser().then((kduser) {
                                blocMember.status(kduser);
                                blocMember.getProduk(username, kduser, token);
                              });
                            });
                          });
                          Toast.show("Produk di set ada!",
                              duration: Toast.lengthLong,
                              gravity: Toast.bottom);
                        }
                      });
                    }
                    if (mounted) setState(() {});
                  },
                  child: Text(
                    makanan.aktif == '0' ? 'Tersedia' : 'Habis',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void handleClick(int item, Datum barang) {
    switch (item) {
      case 0:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditProductPage(produk: barang)));
        break;
      case 1:
        break;
    }
  }
}
