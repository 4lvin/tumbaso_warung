import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tumbaso_warung/src/bloc/memberBloc.dart';
import 'package:tumbaso_warung/src/models/getProdukModel.dart';
import 'package:tumbaso_warung/src/pref/preferences.dart';
import 'package:tumbaso_warung/src/ui/utils/colorses.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    getToken().then((token) {
      getUsername().then((username) {
        getKdUser().then((kduser) {
          blocMember.getProduk(username, kduser, token);
        });
      });
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    getToken().then((token) {
      getUsername().then((username) {
        getKdUser().then((kduser) {
          blocMember.getProduk(username, kduser, token);
        });
      });
    });
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    getToken().then((token) {
      getUsername().then((username) {
        getKdUser().then((kduser) {
          blocMember.getProduk(username, kduser, token);
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            color: colorses.background,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SafeArea(
                  child: Container(
                    height: 100,
                    width: 100,
                    child: Image.asset(
                      "assets/iconw.png",
                      scale: 5,
                    ),
                  ),
                )
              ],
            ),
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
                                  return Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.white, border: Border(bottom: BorderSide(color: Colors.grey[200]))),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(builder: (context) => DetailPesanan(pesanan: snapshot.data.data[i],)),
                                            // );
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
                                                  width: 50,
                                                  height: 50,
                                                ),
                                                Container(
                                                    margin: EdgeInsets.only(top: 5),
                                                    width: 80,
                                                    height: 100,
                                                    child: Hero(
                                                        tag: "notif$i",
                                                        child: Image.network("http://jongjava.tech/tumbas/assets/foto_produk/" +
                                                            snapshot.data.data[i].gambar.gambar1))),
                                              ],
                                            ),
                                            title: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  snapshot.data.data[i].namaProduk,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  snapshot.data.data[i].hargaJual,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: TextStyle(fontSize: 14),
                                                )
                                                // Text(
                                                //   formatDate,
                                                //   overflow: TextOverflow.ellipsis,
                                                //   maxLines: 2,
                                                //   style: TextStyle(fontSize: 12),
                                                // ),
                                              ],
                                            ),
                                            // trailing: Column(
                                            //   crossAxisAlignment: CrossAxisAlignment.end,
                                            //   mainAxisAlignment: MainAxisAlignment.end,
                                            //   children: <Widget>[
                                            //     Container(
                                            //       padding: EdgeInsets.only(left: 7, top: 0),
                                            //       height: 18,
                                            //       child: Text(
                                            //         formatDate,
                                            //         style: TextStyle(color: Colors.grey, fontSize: 13),
                                            //       ),
                                            //     ),
                                            //     Container(
                                            //       child: Text(
                                            //         formatTime,
                                            //         style: TextStyle(color: Colors.grey, fontSize: 12),
                                            //       ),
                                            //     )
                                            //   ],
                                            // ),
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
                                    "Tidak Ada Pesanan",
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
    );
  }
}
