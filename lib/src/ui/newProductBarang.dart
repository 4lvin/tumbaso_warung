import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:tumbaso_warung/src/bloc/memberBloc.dart';
import 'package:tumbaso_warung/src/bloc/produkPasmakBloc.dart';
import 'package:tumbaso_warung/src/models/getKategoriBarangModel.dart';
import 'package:tumbaso_warung/src/models/getSubKategoriModel.dart';
import 'package:tumbaso_warung/src/ui/produkBarang.dart';
import 'package:tumbaso_warung/src/ui/utils/colorses.dart';
import 'package:tumbaso_warung/src/ui/utils/loading.dart';

class NewProductBarang extends StatefulWidget {
  @override
  _NewProductBarangState createState() => _NewProductBarangState();
}

class _NewProductBarangState extends State<NewProductBarang> {
  PickedFile imageFile;

  String kategori;
  String sub_kategori;

  var nama = TextEditingController();
  var harga = TextEditingController();
  var berat = TextEditingController();
  var stok = TextEditingController();
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

  void _onSimpan() {
    if (kategori == null || harga.text == "" || nama.text == "" || keterangan.text == "") {
      Toast.show("Form tidak boleh kosong", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    File file = imageFile != null ? File(imageFile.path) : null;
    Dialogs.showLoading(context, "Loading...");
    blocProdukPasmak
        .simpanProductBarang(file, kategori, sub_kategori ?? "", nama.text, harga.text, satuan.text, berat.text, deskripsi.text,
            keterangan.text, minimum.text, stok.text)
        .then((value) {
      if (value != 200) {
        Dialogs.dismiss(context);
        Future.delayed(Duration(seconds: 1)).then((value) {
          Toast.show("Berhasil Menyimpan Data", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        });
      } else {
        Dialogs.dismiss(context);
        Future.delayed(Duration(seconds: 1)).then((value) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => ProdukBarang()),
            ModalRoute.withName('/controllerPage'),
          );
        });
      }
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
            padding: EdgeInsets.only(top: 20.0, bottom: 60),
            child: Column(
              children: [
                buildImage(context),
                SizedBox(height: 20.0),
                pilihKategori(context),
                SizedBox(height: 10.0),
                pilihSubKategori(context),
                SizedBox(height: 10.0),
                buildInput(
                  context,
                  'Nama Produk',
                  'Masukkan Nama Produk',
                  nama,
                ),
                SizedBox(height: 10.0),
                buildInput(
                  context,
                  'Harga',
                  'Masukkan Harga',
                  harga,
                  input: TextInputType.number,
                ),
                SizedBox(height: 10.0),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildInput2(
                        context,
                        'Berat',
                        '1000',
                        berat,
                        input: TextInputType.number,
                      ),
                      SizedBox(width: 20),
                      buildInput2(
                        context,
                        'Satuan',
                        'gram',
                        satuan,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                buildInput(
                  context,
                  "Stok",
                  "Masukkan Stok",
                  stok,
                ),
                SizedBox(height: 10.0),
                buildInput(
                  context,
                  "Deskripsi",
                  "Masukkan Deskripsi",
                  deskripsi,
                ),
                SizedBox(height: 10.0),
                buildInput(
                  context,
                  "Keterangan",
                  "Masukkan Keterangan",
                  keterangan,
                ),
                SizedBox(height: 10.0),
                buildInput(
                  context,
                  "Minimum",
                  "Masukkan Minimum Pemesanan",
                  minimum,
                  input: TextInputType.number,
                ),
                SizedBox(height: 20.0),
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
                      _onSimpan();
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
    );
  }

  Widget buildInput(BuildContext context, String title, String hint, TextEditingController controller,
      {TextInputType input = TextInputType.name}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
          child: Text(title),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: colorses.dasar),
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: input,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildInput2(BuildContext context, String title, String hint, TextEditingController controller,
      {TextInputType input = TextInputType.name}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(title),
        ),
        Container(
          margin: EdgeInsets.only(top: 5, bottom: 5),
          padding: EdgeInsets.only(left: 20, top: 1, bottom: 1),
          width: MediaQuery.of(context).size.width * 0.8 / 2 - 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: colorses.dasar),
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: input,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  Widget pilihSubKategori(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
          child: Text('Sub Kategori'),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: colorses.dasar),
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
      ],
    );
  }

  Widget pilihKategori(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
          child: Text('Kategori'),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: colorses.dasar),
          ),
          child: DropdownButtonHideUnderline(
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
        ),
      ],
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
