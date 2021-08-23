import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:tumbaso_warung/src/bloc/memberBloc.dart';
import 'package:tumbaso_warung/src/bloc/produkPasmakBloc.dart';
import 'package:tumbaso_warung/src/models/getKategoriBarangModel.dart';
import 'package:tumbaso_warung/src/models/getSubKategoriModel.dart';
import 'package:tumbaso_warung/src/ui/utils/colorses.dart';
import 'package:tumbaso_warung/src/ui/utils/loading.dart';

class NewProductBarang extends StatefulWidget {
  @override
  _NewProductBarangState createState() => _NewProductBarangState();
}

class _NewProductBarangState extends State<NewProductBarang> {
  PickedFile imageFile;

  String kategori;

  // ignore: non_constant_identifier_names
  String sub_kategori;
  var nama = TextEditingController();
  var harga = TextEditingController();
  var berat = TextEditingController();
  var deskripsi = TextEditingController();
  var satuan = TextEditingController();
  var keterangan = TextEditingController();
  var minimum = TextEditingController();
  String gambar_1;

  GetKategoriBarangModel _listKategori;
  GetSubKategoriBarangModel _listSubkategori;

  Future getImage(int type) async {
    PickedFile pickedImage =
        await ImagePicker().getImage(source: type == 1 ? ImageSource.camera : ImageSource.gallery, imageQuality: 50);
    return pickedImage;
  }

  @override
  void initState() {
    blocProdukPasmak.getKategoriBarang();
    blocProdukPasmak.resKategori.listen((event) {
      if (mounted)
        setState(() {
          _listKategori = event;
        });
    });
    super.initState();
  }

  getSubkategori(idKategori) {
    blocProdukPasmak.getSubKategoriBarang(idKategori);
    blocProdukPasmak.resSubKategori.listen((event) {
      setState(() {
        _listSubkategori = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorses.dasar,
          // iconTheme: IconThemeData(
          //   color: Colors.black, //change your color here
          // ),
          title: Text(
            "Produk Baru",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 60),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width * 0.3,
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 4,
                            blurRadius: 4,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        image: DecorationImage(
                            image: imageFile == null ? AssetImage('assets/baru2.png') : FileImage(File(imageFile.path)),
                            fit: BoxFit.cover)),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(top: 2.0),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Center(
                          child: ElevatedButton(
                        onPressed: () async {
                          final tmpFile = await getImage(2);

                          setState(() {
                            imageFile = tmpFile;
                          });
                        },
                        child: Text(
                          'Upload Gambar',
                          textAlign: TextAlign.center,
                        ),
                      )),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: colorses.background,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton(
                      isExpanded: true,
                      hint: Text("Pilih Kategori"),
                      value: kategori,
                      items: _listKategori == null
                          ? []
                          : _listKategori.data.map((value) {
                              return DropdownMenuItem(
                                child: Text(value.namaKategori),
                                value: value.idKategori,
                              );
                            }).toList(),
                      onChanged: (value) {
                        getSubkategori(value);
                        setState(() {
                          kategori = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: colorses.background,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton(
                      isExpanded: true,
                      hint: Text("Pilih Subkategori"),
                      value: sub_kategori,
                      items: _listSubkategori == null
                          ? []
                          : _listSubkategori.data.map((value) {
                              return DropdownMenuItem(
                                child: Text(value.namaSubkategori),
                                value: value.idSubkategori,
                              );
                            }).toList(),
                      onChanged: (value) {
                        setState(() {
                          sub_kategori = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: colorses.background,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      controller: nama,
                      decoration: InputDecoration(
                          labelText: "Nama Produk*",
                          labelStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[500]))),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: colorses.background,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      controller: harga,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Harga*",
                          labelStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[500]))),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5, left: 40),
                          padding: EdgeInsets.only(left: 20, top: 1, bottom: 1),
                          width: MediaQuery.of(context).size.width * 0.8 / 2 - 10,
                          decoration: BoxDecoration(
                            color: colorses.background,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            controller: berat,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: "Berat*",
                                labelStyle: TextStyle(color: Colors.grey),
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[500]))),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5, right: 40),
                          padding: EdgeInsets.only(left: 20, top: 1, bottom: 1),
                          width: MediaQuery.of(context).size.width * 0.8 / 2 - 10,
                          decoration: BoxDecoration(
                            color: colorses.background,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            controller: satuan,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                labelText: "Satuan*",
                                labelStyle: TextStyle(color: Colors.grey),
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[500]))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: colorses.background,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      controller: deskripsi,
                      decoration: InputDecoration(
                          labelText: "Deskripsi*",
                          labelStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[500]))),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: colorses.background,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      controller: keterangan,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: "Keterangan*",
                          labelStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[500]))),
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
                    child: TextFormField(
                      controller: minimum,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Minimum*",
                          labelStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[500]))),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        bottomSheet: InkWell(
          onTap: () {
            Dialogs.showLoading(context, "Loading...");
            File file = imageFile != null ? File(imageFile.path) : null;
            if (kategori == null || sub_kategori == null || harga.text == "" || nama.text == "") {
              Toast.show("Lengkapi Data anda", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              return;
            }
            blocProdukPasmak
                .simpanProductBarang(file, kategori, sub_kategori, nama.text, harga.text, satuan.text, berat.text, deskripsi.text,
                    keterangan.text, minimum.text)
                .then((value) {
              if (value != 200) {
                Dialogs.dismiss(context);
                Future.delayed(Duration(seconds: 1)).then((value) {
                  Toast.show("Berhasil Menyimpan Data", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                });
              } else {
                Dialogs.dismiss(context);
                Future.delayed(Duration(seconds: 1)).then((value) {
                  Navigator.of(context).pushNamedAndRemoveUntil('/controllerPage', (route) => false);
                });
              }
            });
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: colorses.dasar,
              borderRadius: BorderRadius.only(topLeft: Radius.elliptical(100.0, 10.0), topRight: Radius.elliptical(100.0, 10.0)),
            ),
            child: Center(
                child: Text(
              "Simpan",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
            )),
          ),
        ));
  }
}
