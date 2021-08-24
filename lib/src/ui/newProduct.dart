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
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: colorses.dasar, width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
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
                  SizedBox(height: 10.0),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: colorses.dasar, width: 1.5),
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
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[500]))),
                    ),
                  ),
                  SizedBox(height: 10.0),
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
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[500]))),
                    ),
                  ),
                  SizedBox(height: 10.0),
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
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[500]))),
                    ),
                  ),
                  SizedBox(height: 10.0),
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
            File file = imageFile != null ? File(imageFile.path) : null;
            if (kategori == null || sub_kategori == null || harga.text == "" || nama.text == "") {
              Toast.show("Lengkapi Data anda", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              return;
            }
            blocMember
                .simpanProduct(file, kategori, sub_kategori, nama.text, harga.text, berat.text, deskripsi.text, potongan.text)
                .then((value) {
              if (value != 200) {
                Toast.show("Berhasil Menyimpan Data", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              } else {
                Navigator.of(context).pushNamedAndRemoveUntil('/controllerPage', (route) => false);
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
