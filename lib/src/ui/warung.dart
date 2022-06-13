import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';
import 'package:tumbaso_warung/src/bloc/memberBloc.dart';
import 'package:tumbaso_warung/src/models/getSetoranModel.dart';
import 'package:tumbaso_warung/src/pref/preferences.dart';
import 'package:tumbaso_warung/src/ui/auth/auth.dart';
import 'package:tumbaso_warung/src/ui/editProfil.dart';
import 'package:tumbaso_warung/src/ui/utils/colorses.dart';

class WarungPage extends StatefulWidget {
  @override
  _WarungPageState createState() => _WarungPageState();
}

class _WarungPageState extends State<WarungPage> {
  bool onOff = false;
  String? nama;
  String? email;

  @override
  void initState() {
    getEmail().then((value) {
      if (mounted)
        setState(() {
          email = value;
        });
    });
    getNama().then((value) {
      if (mounted)
        setState(() {
          nama = value;
        });
    });

    getKdUser().then((kduser) {
      blocMember.getSetoranProduct(kduser);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: nama == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  color: Colors.grey[200],
                  child: Stack(
                    children: <Widget>[
                      Container(
                          height: MediaQuery.of(context).size.height / 4 - 50,
                          color: colorses.dasar,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [colorses.dasar, colorses.dasar]),
                            ),
                          )),
                      Align(
                        alignment: Alignment.topCenter,
                        child: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Profil",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  width: 80,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Icon(
                                        Icons.notifications,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      Icon(Icons.settings, color: Colors.white)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    duration: Duration(milliseconds: 200),
                                    child: EditProfil(
                                      email: email!,
                                    )));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            height: 100,
                            width: MediaQuery.of(context).size.width - 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: colorses.dasar),
                                  width: 70,
                                  height: 70,
                                  child: Icon(
                                    Icons.person,
                                    size: 60,
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  width: 180,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "$nama",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      // Text(
                                      //   "$alamat",
                                      //   style: TextStyle(fontSize: 14, color: Colors.grey),
                                      // ),
                                      // Text(
                                      //   "$telp",
                                      //   style: TextStyle(fontSize: 14, color: Colors.grey),
                                      // )
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.only(top: 5),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(16),
                //     color: Colors.white,
                //   ),
                //   height: 55,
                //   width: MediaQuery.of(context).size.width - 50,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: <Widget>[
                //       Icon(Icons.warning),
                //       Container(
                //         width: 200,
                //         child: Text(
                //           "Lapor",
                //           textAlign: TextAlign.left,
                //         ),
                //       ),
                //       Icon(
                //         Icons.arrow_forward_ios,
                //         size: 16,
                //       )
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 45, right: 45),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white),
                          height: 80,
                          child: Column(
                            children: [
                              Text(
                                'Setoran Penjual',
                                style: TextStyle(
                                    color: colorses.dasar,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              StreamBuilder(
                                  stream: blocMember.listSetoran,
                                  builder: (context,
                                      AsyncSnapshot<GetSetoranModel> snapshot) {
                                    if (snapshot.hasData) {
                                      return snapshot.data!.data!.isEmpty
                                          ? Text(
                                              "-",
                                              style: TextStyle(
                                                  color: colorses.dasar,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Text(
                                              snapshot
                                                  .data!.data![0].setorPenjual!
                                                  .toString(),
                                              style: TextStyle(
                                                  color: colorses.dasar,
                                                  fontWeight: FontWeight.w500),
                                            );
                                    } else {
                                      return Text(
                                        "-",
                                        style: TextStyle(
                                            color: colorses.dasar,
                                            fontWeight: FontWeight.w500),
                                      );
                                    }
                                  }),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white),
                          height: 80,
                          child: Column(
                            children: [
                              Text(
                                'Tunggakan Setoran\n Penjual',
                                style: TextStyle(
                                    color: colorses.dasar,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              StreamBuilder(
                                  stream: blocMember.listSetoran,
                                  builder: (context,
                                      AsyncSnapshot<GetSetoranModel> snapshot) {
                                    if (snapshot.hasData) {
                                      return snapshot.data!.data!.isEmpty
                                          ? Text(
                                              "-",
                                              style: TextStyle(
                                                  color: colorses.dasar,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Text(
                                              snapshot.data!.data![0]
                                                  .tunggakanSetor!
                                                  .toString(),
                                              style: TextStyle(
                                                  color: colorses.dasar,
                                                  fontWeight: FontWeight.w500),
                                            );
                                    } else {
                                      return Text(
                                        "-",
                                        style: TextStyle(
                                            color: colorses.dasar,
                                            fontWeight: FontWeight.w500),
                                      );
                                    }
                                  }),
                            ],
                          ),
                        ),
                      ]),
                ),
                SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    signOutAccount();
                    Navigator.pushReplacementNamed(context, "/login");
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.red[100],
                        border: Border.all(color: Colors.red)),
                    height: 55,
                    width: MediaQuery.of(context).size.width - 50,
                    child: Center(
                        child: Text(
                      "Logout",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
    );
  }
}
