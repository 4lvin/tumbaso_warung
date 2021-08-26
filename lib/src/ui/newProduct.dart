import 'dart:io';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:tumbaso_warung/src/bloc/memberBloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tumbaso_warung/src/models/resSubkategoriModel.dart';
import 'package:tumbaso_warung/src/ui/utils/colorses.dart';

class NewProductPage extends StatefulWidget {
  @override
  _NewProductPageState createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  PickedFile imageFile;

  String kategori;

  // ignore: non_constant_identifier_names
  String sub_kategori;
  var nama = TextEditingController();
  var harga = TextEditingController();
  var berat = TextEditingController();
  var deskripsi = TextEditingController();
  var potongan = TextEditingController();
  String gambar_1;

  List<Map<String, dynamic>> _listKategori = [
    {"id_kategori": "1", "nama_kategori": "Makanan"},
    {"id_kategori": "2", "nama_kategori": "Belanja"},
    {"id_kategori": "3", "nama_kategori": "Hobi"},
    {"id_kategori": "4", "nama_kategori": "Pakaian"}
  ];
  ResSubkategoriModel _listSubkategori;

  Future getImage(int type) async {
    PickedFile pickedImage =
        await ImagePicker().getImage(source: type == 1 ? ImageSource.camera : ImageSource.gallery, imageQuality: 50);
    return pickedImage;
  }

  getSubkategori(idKategori) {
    blocMember.getSubkategori(idKategori).then((value) {
      setState(() {
        _listSubkategori = value;
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
                  buildImage(context),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 30),
                      padding: EdgeInsets.symmetric(vertical: 1),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text("Nama Produk")),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: colorses.dasar, width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      controller: nama,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: "Nama Produk*",
                          labelStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 30),
                      padding: EdgeInsets.symmetric(vertical: 1),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text("Kategori")),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: colorses.dasar, width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isExpanded: true,
                        hint: Text("Pilih Kategori"),
                        value: kategori,
                        items: _listKategori.map((value) {
                          return DropdownMenuItem(
                            child: Text(value["nama_kategori"]),
                            value: value["id_kategori"],
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
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 30),
                      padding: EdgeInsets.symmetric(vertical: 1),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text("Sub Kategori")),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: colorses.dasar, width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
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
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 30),
                      padding: EdgeInsets.symmetric(vertical: 1),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text("Harga")),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: colorses.dasar, width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      controller: harga,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Harga*",
                        labelStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 30),
                      padding: EdgeInsets.symmetric(vertical: 1),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text("Berat")),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: colorses.dasar, width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      controller: berat,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Berat*",
                        labelStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 30),
                      padding: EdgeInsets.symmetric(vertical: 1),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text("Deskripsi")),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      border: Border.all(color: colorses.dasar, width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      controller: deskripsi,
                      decoration: InputDecoration(
                        labelText: "Deskripsi*",
                        labelStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 30),
                      padding: EdgeInsets.symmetric(vertical: 1),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text("Keterangan")),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: colorses.dasar, width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      controller: potongan,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Potongan*",
                        labelStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 12,),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(colorses.orange),
                        elevation: MaterialStateProperty.all(2),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        File file = imageFile != null ? File(imageFile.path) : null;
                        if (kategori == null || sub_kategori == null || harga.text == "" || nama.text == "") {
                          Toast.show("Lengkapi Data anda", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                          return;
                        }
                        blocMember
                            .simpanProduct(
                                file, kategori, sub_kategori, nama.text, harga.text, berat.text, deskripsi.text, potongan.text)
                            .then((value) {
                          if (value != 200) {
                            Toast.show("Berhasil Menyimpan Data", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                          } else {
                            Navigator.of(context).pushNamedAndRemoveUntil('/controllerPage', (route) => false);
                          }
                        });
                      },
                      child: Text(
                        'Simpan',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        // bottomSheet: InkWell(
        //   onTap: () {
        //     File file = imageFile != null ? File(imageFile.path) : null;
        //     if (kategori == null || sub_kategori == null || harga.text == "" || nama.text == "") {
        //       Toast.show("Lengkapi Data anda", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        //       return;
        //     }
        //     blocMember
        //         .simpanProduct(file, kategori, sub_kategori, nama.text, harga.text, berat.text, deskripsi.text, potongan.text)
        //         .then((value) {
        //       if (value != 200) {
        //         Toast.show("Berhasil Menyimpan Data", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        //       } else {
        //         Navigator.of(context).pushNamedAndRemoveUntil('/controllerPage', (route) => false);
        //       }
        //     });
        //   },
        //   child: Container(
        //     height: 50,
        //     decoration: BoxDecoration(
        //       color: colorses.dasar,
        //       borderRadius: BorderRadius.only(topLeft: Radius.elliptical(100.0, 10.0), topRight: Radius.elliptical(100.0, 10.0)),
        //     ),
        //     child: Center(
        //         child: Text(
        //       "Simpan",
        //       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
        //     )),
        //   ),
        // )
    );
  }

  Widget buildImage(BuildContext context) {
    if (imageFile == null) {
      return GestureDetector(
        onTap: () async {
          final tmpFile = await getImage(2);

          setState(() {
            imageFile = tmpFile;
          });
        },
        child: Container(
          height: MediaQuery.of(context).size.width * 0.3,
          width: MediaQuery.of(context).size.width * 0.34,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 4,
                blurRadius: 4,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
            border: Border.all(
              width: 2,
              color: colorses.orange,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.camera_alt, color: colorses.orange, size: 35),
              Text(
                'Unggah Foto',
                style: TextStyle(fontSize: 16, color: colorses.orange),
              ),
            ],
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () async {
          final tmpFile = await getImage(2);

          setState(() {
            imageFile = tmpFile;
          });
        },
        child: Container(
          height: MediaQuery.of(context).size.width * 0.3,
          width: MediaQuery.of(context).size.width * 0.34,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 4,
                blurRadius: 4,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            image: DecorationImage(
              image: FileImage(
                File(imageFile.path),
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }
  }
}
