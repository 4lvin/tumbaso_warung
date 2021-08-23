import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:toast/toast.dart';
import 'package:tumbaso_warung/src/bloc/memberBloc.dart';
import 'package:tumbaso_warung/src/models/getKecamatanModel.dart';
import 'package:tumbaso_warung/src/models/getKotaModel.dart';
import 'package:tumbaso_warung/src/models/getProvinsiModel.dart';
import 'package:tumbaso_warung/src/pref/preferences.dart';
import 'package:tumbaso_warung/src/ui/utils/colorses.dart';
import 'package:tumbaso_warung/src/ui/utils/loading.dart';

// ignore: must_be_immutable
class LengkapiProfil extends StatefulWidget {
  LengkapiProfil({this.email, this.token, this.kdUser, this.nama, this.kdPasmak});

  String email;
  String token;
  String kdUser;
  String nama;
  String kdPasmak;

  @override
  _LengkapiProfilState createState() => _LengkapiProfilState();
}

class _LengkapiProfilState extends State<LengkapiProfil> {
  TextEditingController _alamat = TextEditingController();
  TextEditingController _nama = TextEditingController();
  TextEditingController _noTelp = TextEditingController();
  int _provinsi;
  String _selectedProvinsi;
  bool _validate = false;
  List<DropdownMenuItem> itemsKot = [];
  int _kotaInt;
  int _kecInt;
  String _selectedKec;
  var longitude;
  var latitude;
  Position positionStream;

  // String _kota;
  String _selectedKota;

  currentPosition() async {
    positionStream = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if (mounted) {
      setState(() {
        longitude = positionStream.longitude;
        latitude = positionStream.latitude;
      });
      print(longitude);
    }
  }

  @override
  void initState() {
    blocMember.getProvinsi();
    currentPosition();
    print(longitude);
    blocMember.resKota.listen((data) {
      for (int i = 0; i < data.data.length; i++) {
        itemsKot.add(new DropdownMenuItem(
          child: new Text(data.data[i].namaKabupaten, style: TextStyle(fontSize: 14.0)),
          value: data.data[i].namaKabupaten,
        ));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lengkapi Profil"),
        backgroundColor: colorses.dasar,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 30, top: 12),
              width: MediaQuery.of(context).size.width / 2 + 150,
              child: Text(
                "Lengkapi Profil Anda Sekarang!",
                style: TextStyle(fontSize: 31, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12, left: 30, bottom: 12),
              width: MediaQuery.of(context).size.width / 2 + 150,
              child: Text(
                "Dapatkan akses Tambah Produk dan fitur lainnya",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: colorses.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _nama,
                cursorColor: colorses.dasar,
                decoration: InputDecoration(
                  hintText: "Nama Toko",
                  border: InputBorder.none,
                  errorText: _nama.text.length < 3 && _validate ? 'Nama Toko harus diisi !' : null,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
              width: MediaQuery.of(context).size.width * 0.8,
              height: 50,
              decoration: BoxDecoration(
                color: colorses.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: StreamBuilder(
                  stream: blocMember.resProvinsi,
                  builder: (context, AsyncSnapshot<GetProvinsiModel> snapshot) {
                    if (snapshot.hasData) {
                      return new DropdownButton<ResultProv>(
                        isExpanded: true,
                        items: snapshot.data.data.map((ResultProv value) {
                          return new DropdownMenuItem<ResultProv>(
                            value: value,
                            child: Container(
                                width: 140.0,
                                child: new Text(
                                  value.namaProvinsi,
                                  style: TextStyle(fontSize: 14.0),
                                )),
                          );
                        }).toList(),
                        value: _provinsi == null ? null : snapshot.data.data[_provinsi],
                        hint: Text(
                          "pilih Provinsi",
                          style: TextStyle(fontSize: 14.0),
                        ),
                        onChanged: (value) {
                          setState(() {
                            FocusScope.of(context).requestFocus(new FocusNode());
                            _provinsi = snapshot.data.data.indexOf(value);
                            _selectedProvinsi = value.idProvinsi;
                            blocMember.getKota(_selectedProvinsi);
                            _kotaInt = 0;
                          });
                        },
                      );
                    }
                    return Container(
                      child: Center(child: Text("loading..")),
                    );
                  }),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
              width: MediaQuery.of(context).size.width * 0.8,
              height: 50,
              decoration: BoxDecoration(
                color: colorses.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: StreamBuilder(
                  stream: blocMember.resKota,
                  builder: (context, AsyncSnapshot<GetKotaModel> snapshot) {
                    if (snapshot.hasData) {
                      return new DropdownButton<ResultKota>(
                        isExpanded: true,
                        items: snapshot.data.data.map((ResultKota value) {
                          return new DropdownMenuItem<ResultKota>(
                            value: value,
                            child: Container(
                                width: 140.0,
                                child: new Text(
                                  value.namaKabupaten,
                                  style: TextStyle(fontSize: 14.0),
                                )),
                          );
                        }).toList(),
                        value: _kotaInt == null ? null : snapshot.data.data[_kotaInt],
                        hint: Text(
                          "pilih Kota",
                          style: TextStyle(fontSize: 14.0),
                        ),
                        onChanged: (value) {
                          setState(() {
                            FocusScope.of(context).requestFocus(new FocusNode());
                            _kotaInt = snapshot.data.data.indexOf(value);
                            _selectedKota = value.idKabupaten;
                            blocMember.getKecamatan(_selectedKota);
                            _kecInt = 0;
                            // itemsKot.clear();
                          });
                        },
                      );
                    }
                    return Container(
                      child: Center(child: Text("Pilih Provinsi terlebih dahulu....")),
                    );
                  }),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
              width: MediaQuery.of(context).size.width * 0.8,
              height: 50,
              decoration: BoxDecoration(
                color: colorses.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: StreamBuilder(
                  stream: blocMember.resKecamatan,
                  builder: (context, AsyncSnapshot<GetKecamatanModel> snapshot) {
                    if (snapshot.hasData) {
                      return new DropdownButton<ResultKec>(
                        isExpanded: true,
                        items: snapshot.data.data.map((ResultKec value) {
                          return new DropdownMenuItem<ResultKec>(
                            value: value,
                            child: Container(
                                width: 140.0,
                                child: new Text(
                                  value.namaKecamatan,
                                  style: TextStyle(fontSize: 14.0),
                                )),
                          );
                        }).toList(),
                        value: _kecInt == null ? null : snapshot.data.data[_kecInt],
                        hint: Text(
                          "pilih Kecamatan",
                          style: TextStyle(fontSize: 14.0),
                        ),
                        onChanged: (value) {
                          setState(() {
                            FocusScope.of(context).requestFocus(new FocusNode());
                            _kecInt = snapshot.data.data.indexOf(value);
                            _selectedKec = value.idKecamatan;
                            // blocMember.getKota(_selectedProvinsi);
                            // itemsKot.clear();
                          });
                        },
                      );
                    }
                    return Container(
                      child: Center(child: Text("Pilih Kota terlebih dahulu..")),
                    );
                  }),
            ),
            // Container(
            //   margin: EdgeInsets.symmetric(vertical: 5,horizontal: 30),
            //   padding: EdgeInsets.symmetric(horizontal: 18, vertical: 0),
            //   width: MediaQuery.of(context).size.width * 0.8,
            //   height: 70,
            //   decoration: BoxDecoration(
            //     color: colorses.background,
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            //   child: StreamBuilder(
            //       stream: blocMember.resKota,
            //       builder: (context, AsyncSnapshot<GetKotaModel> snapshot) {
            //         if(snapshot.hasData){
            //           return SearchableDropdown(
            //             isExpanded: true,
            //             items: itemsKot,
            //             value: _kota,
            //             hint: Text(
            //               "pilih Kota",
            //               style: TextStyle(fontSize: 14.0),
            //             ),
            //             onChanged: (value) {
            //               setState(() {
            //                 FocusScope.of(context).requestFocus(new FocusNode());
            //                 for(int i=0; i < snapshot.data.data.length; i++){
            //                   if(value == snapshot.data.data[i].namaKabupaten){
            //                     _selectedKota = snapshot.data.data[i].idKabupaten;
            //                   }
            //                 }
            //                 _kota = value;
            //                 // masterBloc.getKelurahan(_selectedKota, _selectedKecamatan);
            //               });
            //             },
            //           );
            //         }
            //         return DropdownButton(
            //           isExpanded: true,
            //           hint: Text(
            //             "pilih Provinsi dulu",
            //             style: TextStyle(fontSize: 14.0),
            //           ),
            //         );
            //       }
            //   ),
            // ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: colorses.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _noTelp,
                cursorColor: colorses.dasar,
                decoration: InputDecoration(
                  hintText: "No Telp",
                  border: InputBorder.none,
                  errorText: _noTelp.text.length < 3 && _validate ? 'No Telp harus diisi !' : null,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: colorses.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _alamat,
                cursorColor: colorses.dasar,
                decoration: InputDecoration(
                  hintText: "Alamat",
                  border: InputBorder.none,
                  errorText: _alamat.text.length < 3 && _validate ? 'Alamat harus diisi !' : null,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if(_nama.text.isEmpty || _selectedProvinsi == null || _selectedKota == null || _selectedKec == null || _noTelp.text.isEmpty || _alamat.text.isEmpty){
                  if(mounted)
                    setState(() {
                      _validate = true;
                    });
                }else{
                Dialogs.showLoading(context, "Loading...");
                blocMember.lengkapiProfil(widget.email, _nama.text, _selectedProvinsi, _selectedKota, _selectedKec, _alamat.text,
                    longitude.toString(), latitude.toString(), _noTelp.text, "",widget.token);
                blocMember.resUpdateProfil.listen((event) {
                  if (event.status) {
                    Dialogs.dismiss(context);
                Future.delayed(Duration(seconds: 1)).then((value) {
                    setToken(widget.token);
                    setEmail(widget.email);
                    setNama(_nama.text);
                    setKdUser(widget.kdUser);
                    setKdPasmak(widget.kdPasmak);
                    Navigator.pushReplacementNamed(context, '/controllerPage');
                });
                  } else {
                    Dialogs.dismiss(context);
                    Toast.show(event.message, context, duration: 3, gravity: Toast.BOTTOM);
                  }
                });
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                decoration: BoxDecoration(
                  color: colorses.dasar,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                    child: Text(
                  "Simpan",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}