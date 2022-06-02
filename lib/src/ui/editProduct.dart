import 'dart:io';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:tumbaso_warung/src/bloc/memberBloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tumbaso_warung/src/models/resSubkategoriModel.dart';
import 'package:tumbaso_warung/src/resources/globalApi.dart';
import 'package:tumbaso_warung/src/ui/utils/colorses.dart';

class EditProductPage extends StatefulWidget {
  final dynamic produk;

  EditProductPage({this.produk});

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  PickedFile? imageFile;

  String? kategori;

  // ignore: non_constant_identifier_names
  String? sub_kategori;
  var nama = TextEditingController();
  var harga = TextEditingController();
  var berat = TextEditingController();
  var deskripsi = TextEditingController();
  var potongan = TextEditingController();
  String? gambar_1;

  List<Map<String, dynamic>> _listKategori = [
    {"id_kategori": "1", "nama_kategori": "Makanan"},
    {"id_kategori": "2", "nama_kategori": "Belanja"},
    {"id_kategori": "3", "nama_kategori": "Hobi"},
    {"id_kategori": "4", "nama_kategori": "Pakaian"}
  ];
  ResSubkategoriModel? _listSubkategori;

  Future getImage(int type) async {
    PickedFile? pickedImage = await ImagePicker().getImage(
        source: type == 1 ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 50);
    return pickedImage;
  }

  getSubkategori(idKategori, idSubkategori) {
    blocMember.getSubkategori(idKategori).then((value) {
      setState(() {
        _listSubkategori = value;
        if (idSubkategori != null) {
          sub_kategori = idSubkategori;
        } else {
          sub_kategori = null;
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getSubkategori(
        widget.produk.kategori.idKategori, widget.produk.idSubkategori);
    kategori = widget.produk.kategori.idKategori;
    nama.text = widget.produk.namaProduk;
    harga.text = widget.produk.hargaJual;
    deskripsi.text = widget.produk.deskripsi;
    berat.text = widget.produk.berat;
    potongan.text = widget.produk.potongan;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Produk Baru",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                // Container(
                //   height: 150,
                //   width: 150,
                //   decoration: BoxDecoration(
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.grey.withOpacity(0.3),
                //           spreadRadius: 4,
                //           blurRadius: 4,
                //           offset: Offset(0, 2), // changes position of shadow
                //         ),
                //       ],
                //       borderRadius: BorderRadius.all(Radius.circular(5.0)),
                //       image: DecorationImage(
                //           image: imageFile == null
                //               ? NetworkImage(
                //                   "${globalMaem}/assets/foto_produk/${widget.produk.gambar.gambar1}")
                //               : FileImage(File(imageFile.path)),
                //           fit: BoxFit.cover)),
                // ),
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
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
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
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: Text("Pilih Kategori"),
                      value: kategori,
                      items: _listKategori.map((value) {
                        return DropdownMenuItem(
                          child: Text(value["nama_kategori"]),
                          value: value["id_kategori"],
                        );
                      }).toList(),
                      onChanged: (value) {
                        getSubkategori(value, null);
                        setState(() {
                          kategori = value.toString();
                        });
                      },
                    ),
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
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text("Pilih Subkategori"),
                      value: sub_kategori,
                      items: _listSubkategori == null
                          ? []
                          : _listSubkategori!.data!.map((value) {
                              return DropdownMenuItem(
                                child: Text(value.namaSubkategori!),
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
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
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
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
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
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                InkWell(
                  onTap: () {
                    File? file = imageFile != null ? File(imageFile!.path) : null;
                    String _idproduk = widget.produk.idProduk;
                    if (sub_kategori == null || harga.text == "") {
                      Toast.show("Lengkapi Data anda",
                          duration: Toast.lengthLong, gravity: Toast.bottom);
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //     content: const Text('Lengkapi Data anda'),
                      //     duration: const Duration(seconds: 3)));
                      return;
                    }
                    blocMember
                        .updateProduct(
                            file!,
                            _idproduk,
                            kategori!,
                            sub_kategori!,
                            nama.text,
                            harga.text,
                            berat.text,
                            deskripsi.text,
                            potongan.text)
                        .then((value) {
                      if (value != 200) {
                        Toast.show("Berhasil Menyimpan Data",
                            duration: Toast.lengthLong, gravity: Toast.bottom);
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //     content: const Text('Berhasil Menyimpan Data'),
                        //     duration: const Duration(seconds: 3)));
                      } else {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/controllerPage', (route) => false);
                      }
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 50,
                    decoration: BoxDecoration(
                      color: colorses.orange,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "Simpan",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
