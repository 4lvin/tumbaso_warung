import 'package:flutter/material.dart';
import 'package:tumbaso_warung/src/bloc/memberBloc.dart';

class NewProductPage extends StatefulWidget {
  @override
  _NewProductPageState createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  var kategori = TextEditingController();
  var nama = TextEditingController();
  var harga = TextEditingController();
  var berat = TextEditingController();
  var deskripsi = TextEditingController();
  var potongan = TextEditingController();
  var utama = TextEditingController();
  var gambar_1 = TextEditingController();
  var gambar_2 = TextEditingController();
  var gambar_3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Buat Produk Baru"),
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          height: 150.0,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Card(
                            child: Center(child: Text("Upload Gambar")),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          height: 150.0,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Card(
                            child: Center(child: Text("Upload Gambar")),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          height: 150.0,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Card(
                            child: Center(child: Text("Upload Gambar")),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: nama,
                    decoration: InputDecoration(
                        labelText: "Nama Produk*",
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[500]))),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: kategori,
                    decoration: InputDecoration(
                        labelText: "Kategori Produk*",
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[500]))),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: harga,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Harga*",
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[500]))),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: berat,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Berat*",
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[500]))),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: deskripsi,
                    decoration: InputDecoration(
                        labelText: "Deskripsi*",
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[500]))),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: potongan,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Potongan*",
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[500]))),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: utama,
                    decoration: InputDecoration(
                        labelText: "Utama*",
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[500]))),
                  ),
                  SizedBox(height: 50.0)
                ],
              ),
            )
          ],
        ),
        bottomSheet: InkWell(
          onTap: () {
            blocMember.simpanProduct(
                kategori.text,
                nama.text,
                harga.text,
                berat.text,
                deskripsi.text,
                potongan.text,
                utama.text,
                gambar_1.text,
                gambar_2.text,
                gambar_3.text);
          },
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.blue[500],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(100.0, 10.0),
                  topRight: Radius.elliptical(100.0, 10.0)),
            ),
            child: Center(
                child: Text(
              "Simpan",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            )),
          ),
        ));
  }
}
