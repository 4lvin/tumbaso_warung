import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:toast/toast.dart';
import 'package:tumbaso_warung/src/bloc/memberBloc.dart';
import 'package:tumbaso_warung/src/bloc/produkPasmakBloc.dart';
import 'package:tumbaso_warung/src/models/getEkspedisiModel.dart';
import 'package:tumbaso_warung/src/models/getKecamatanModel.dart';
import 'package:tumbaso_warung/src/models/getKotaModel.dart';
import 'package:tumbaso_warung/src/models/getProvinsiModel.dart';
import 'package:tumbaso_warung/src/pref/preferences.dart';
import 'package:tumbaso_warung/src/ui/utils/colorses.dart';
import 'package:tumbaso_warung/src/ui/utils/loading.dart';

// ignore: must_be_immutable
class EditProfil extends StatefulWidget {
  EditProfil({this.email});

  String? email;

  @override
  _EditProfilState createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {
  TextEditingController _alamat = TextEditingController();
  TextEditingController _nama = TextEditingController();
  TextEditingController _namaToko = TextEditingController();
  TextEditingController _noTelp = TextEditingController();
  TextEditingController _provinsi = TextEditingController();
  TextEditingController _kota = TextEditingController();
  TextEditingController _kecamatan = TextEditingController();
  String? _selectedProvinsi;
  bool _validate = false;
  List<DropdownMenuItem> itemsKot = [];
  int? _kotaInt;
  int? _kecInt;
  String? _selectedKec;
  var longitude;
  var latitude;
  Position? positionStream;
  String? token;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  PersistentBottomSheetController? _controller;
  List<Datum> ekspedisi = <Datum>[];
  bool check = false;
  List<bool>? _isChecked;
  List? namaEkspedisi;

  String? _selectedKota;
  String _agen = "";

  currentPosition() async {
    positionStream = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if (mounted) {
      setState(() {
        longitude = positionStream!.longitude;
        latitude = positionStream!.latitude;
      });
    }
  }

  @override
  void initState() {
    currentPosition();
    getToken().then((value) {
      print(value);
      if (mounted)
        setState(() {
          token = value;
        });
    });
    blocMember.getProvinsi();
    // blocProdukPasmak.getEkspedisi();
    // blocProdukPasmak.resEkspedisi.listen((event) {
    //   ekspedisi.addAll(event.data);
    //   if (mounted)
    //     setState(() {
    //       _isChecked = List<bool>.filled(event.data.length, false);
    //       namaEkspedisi = List.filled(_isChecked.length, "").toList();
    //     });
    // });
    blocMember.resKota.listen((data) {
      for (int i = 0; i < data.data!.length; i++) {
        itemsKot.add(new DropdownMenuItem(
          child: new Text(data.data![i].namaKabupaten!, style: TextStyle(fontSize: 14.0)),
          value: data.data?[i].namaKabupaten,
        ));
      }
    });
    getToken().then((token){
      getEmail().then((email){
        blocMember.getProfil(email,token);
      });
    });
    blocMember.resGetrofil.listen((event) {
      if (mounted)
        setState(() {
          var profil = event.data![0];
          _alamat.text = profil.alamat!;
          _nama.text = profil.nama!;
          _namaToko.text = profil.namaToko!;
          _noTelp.text = profil.telepone!;
          _selectedProvinsi = profil.provinsiId;
          _selectedKota = profil.kotaId;
          _selectedKec = profil.kecamatanId;
          // _agen = profil.agen;
          blocMember.getProvinsi();
          blocMember.getKota(profil.provinsiId!);
          blocMember.getKecamatan(profil.kotaId!);
          // String kurir = profil.pilihanKurir!;
          // if (kurir != ""||kurir!=null) {
          //   List<String> listKurir = kurir.split(',');
          //   namaEkspedisi.clear();
          //   listKurir.forEach((e) {
          //     _isChecked[int.parse(e)] = true;
          //     namaEkspedisi.add(e);
          //   });
          // }
        });
    });

    Timer(Duration(seconds: 2), () {
      blocMember.resProvinsi.listen((prov) {
        for (var i = 0; i < prov.data!.length; i++) {
          if (prov.data![i].idProvinsi == _selectedProvinsi) {
            if (mounted)
              setState(() {
                _provinsi.text = prov.data![i].namaProvinsi!;
              });
          }
        }
      });
    });
    Timer(Duration(seconds: 1), () {
      blocMember.resKota.listen((kota) {
        for (var i = 0; i < kota.data!.length; i++) {
          if (kota.data![i].idKabupaten == _selectedKota) {
            if (mounted)
              setState(() {
                _kota.text = kota.data![i].namaKabupaten!;
              });
          }
        }
      });
    });
    Timer(Duration(seconds: 1), () {
      blocMember.resKecamatan.listen((kec) {
        for (var i = 0; i < kec.data!.length; i++) {
          if (kec.data![i].idKecamatan == _selectedKec) {
            if (mounted)
              setState(() {
                _kecamatan.text = kec.data![i].namaKecamatan!;
              });
          }
        }
      });
    });
    super.initState();
  }

  _onSave() async {
    // String kurir = '';
    // namaEkspedisi.forEach((element) {
    //   if (kurir == '') {
    //     kurir = element;
    //   } else {
    //     kurir = kurir + ',' + element;
    //   }
    // });
    if (_nama.text.isEmpty ||
        _selectedProvinsi == null ||
        _selectedKota == null ||
        _selectedKec == null ||
        _noTelp.text.isEmpty ||
        _alamat.text.isEmpty) {
      if (mounted)
        setState(() {
          _validate = true;
        });
    } else {
      Dialogs.showLoading(context, "Loading...");
      blocMember.lengkapiProfil(widget.email!, _nama.text, _namaToko.text, _selectedProvinsi!, _selectedKota!, _selectedKec!,
          _alamat.text, longitude.toString(), latitude.toString(), _noTelp.text, "", token!, _agen);
      blocMember.resUpdateProfil.listen((event) {
        if (event.status!) {
          Dialogs.dismiss(context);
          Future.delayed(Duration(seconds: 1)).then((value) {
            Navigator.pushReplacementNamed(context, '/controllerPage');
          });
        } else {
          Dialogs.dismiss(context);
          Toast.show(event.message!, duration: 3, gravity: Toast.bottom);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2, color: colorses.dasar),
              ),
              child: TextField(
                controller: _nama,
                cursorColor: colorses.dasar,
                decoration: InputDecoration(
                  hintText: "Nama",
                  border: InputBorder.none,
                  errorText: _nama.text.length < 3 && _validate ? 'Nama harus diisi !' : null,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2, color: colorses.dasar),
              ),
              child: TextField(
                controller: _namaToko,
                cursorColor: colorses.dasar,
                decoration: InputDecoration(
                  hintText: "Nama Toko",
                  border: InputBorder.none,
                  errorText: _namaToko.text.length < 3 && _validate ? 'Nama Toko harus diisi !' : null,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
              width: MediaQuery.of(context).size.width * 0.8,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: colorses.dasar),
                  color: Colors.grey[200]),
              child: TextField(
                style: TextStyle(color: Colors.grey),
                controller: _provinsi,
                cursorColor: colorses.dasar,
                decoration: InputDecoration(
                  hintText: "Provinsi",
                  enabled: false,
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
              width: MediaQuery.of(context).size.width * 0.8,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: colorses.dasar),
                  color: Colors.grey[200]),
              child: TextField(
                style: TextStyle(color: Colors.grey),
                controller: _kota,
                cursorColor: colorses.dasar,
                decoration: InputDecoration(
                  hintText: "Kota",
                  enabled: false,
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
              width: MediaQuery.of(context).size.width * 0.8,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: colorses.dasar),
                  color: Colors.grey[200]),
              child: TextField(
                style: TextStyle(color: Colors.grey),
                controller: _kecamatan,
                cursorColor: colorses.dasar,
                decoration: InputDecoration(
                  hintText: "Kecamatan",
                  enabled: false,
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2, color: colorses.dasar),
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
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2, color: colorses.dasar),
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
            // InkWell(
            //   onTap: () {
            //     _controller = _scaffoldKey.currentState!.showBottomSheet((BuildContext context) {
            //       return Container(
            //         height: MediaQuery.of(context).size.height,
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            //             boxShadow: [
            //               BoxShadow(
            //                 color: Colors.grey,
            //                 blurRadius: 5.0,
            //               ),
            //             ]),
            //         child: Column(
            //           children: <Widget>[
            //             SafeArea(
            //               child: Container(
            //                 height: 50,
            //                 padding: EdgeInsets.only(top: 0),
            //                 width: MediaQuery.of(context).size.width,
            //                 decoration: BoxDecoration(color: Colors.white, boxShadow: [
            //                   BoxShadow(
            //                     color: Colors.grey,
            //                     blurRadius: 8.0,
            //                   ),
            //                 ]),
            //                 child: Center(child: Text("Pilih Ekspedisi")),
            //               ),
            //             ),
            //             Expanded(
            //                 child: Container(
            //                     margin: EdgeInsets.only(top: 1),
            //                     width: MediaQuery.of(context).size.width,
            //                     color: Colors.white,
            //                     child: bottomSheetEkspedisi())),
            //           ],
            //         ),
            //       );
            //     });
            //   },
            //   child: Container(
            //     margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
            //     width: MediaQuery.of(context).size.width * 0.8,
            //     height: 50,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10),
            //       border: Border.all(width: 2, color: colorses.dasar),
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text("Ekspedisi"),
            //         Text(
            //           "$namaEkspedisi",
            //           overflow: TextOverflow.ellipsis,
            //           style: TextStyle(color: Colors.grey),
            //         ),
            //         Icon(
            //           Icons.arrow_forward_ios,
            //           size: 14,
            //           color: Colors.grey,
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            InkWell(
              onTap: () => _onSave(),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                decoration: BoxDecoration(
                  color: colorses.orange,
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

  // Widget bottomSheetEkspedisi() {
  //   return Padding(
  //       padding: const EdgeInsets.only(top: 8.0, left: 24, right: 24),
  //       child: Container(
  //           //height: MediaQuery.of(context).size.height / 3,
  //           color: Colors.white,
  //           child: ListView.builder(
  //               // physics: NeverScrollableScrollPhysics(),
  //               shrinkWrap: true,
  //               itemCount: ekspedisi.length,
  //               itemBuilder: (BuildContext context, int i) {
  //                 return CheckboxListTile(
  //                   title: Text(ekspedisi[i].namaKurir),
  //                   value: _isChecked[i],
  //                   onChanged: (val) {
  //                     _controller.setState(
  //                       () {
  //                         _isChecked[i] = val;
  //                         if (_isChecked[i] == true) {
  //                           namaEkspedisi.add(ekspedisi[i].idKurir);
  //                         } else {
  //                           namaEkspedisi.remove("");
  //                           namaEkspedisi[i] = "";
  //                         }
  //                         namaEkspedisi.removeWhere((value) => value == "");
  //                       },
  //                     );
  //                     setState(() {});
  //                   },
  //                 );
  //               })));
  // }
}
