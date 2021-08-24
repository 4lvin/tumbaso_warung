import 'package:flutter/material.dart';
import 'package:tumbaso_warung/src/bloc/produkPasmakBloc.dart';
import 'package:tumbaso_warung/src/models/getBarangModel.dart';
import 'package:tumbaso_warung/src/ui/editProductBarang.dart';
import 'package:tumbaso_warung/src/ui/newProductBarang.dart';
import 'package:tumbaso_warung/src/ui/utils/colorses.dart';

class ProdukBarang extends StatefulWidget {
  @override
  _ProdukBarangState createState() => _ProdukBarangState();
}

class _ProdukBarangState extends State<ProdukBarang> {
  @override
  void initState() {
    super.initState();
    blocProdukPasmak.getBarang();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text("Produk Barang"),
          backgroundColor: colorses.dasar,
        ),
        body: body(size),
        floatingActionButton: new FloatingActionButton(
          backgroundColor: colorses.dasar,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewProductBarang()),
            );
          },
          child: const Icon(Icons.add),
        ));
  }

  Widget body(Size size) {
    return Container(
      padding: EdgeInsets.all(20),
      child: StreamBuilder<GetBarangModel>(
          stream: blocProdukPasmak.resBarang,
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.data.isEmpty) {
                return Center(
                  child: Text('Data Kosong..'),
                );
              } else {
                return ListView.builder(
                  padding: EdgeInsets.all(0),
                  itemCount: snapshot.data.data.length,
                  itemBuilder: (context, index) {
                    return buildItems(size, snapshot.data.data[index]);
                  },
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget buildItems(Size size, DatumBarang barang) {
    return Container(
      width: size.width,
      height: size.height * 0.12,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black12,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: 'https://tumbasonline.com/pasarmakmur/asset/foto_produk/${barang.gambar}' !=
                        'https://tumbasonline.com/pasarmakmur/asset/foto_produk/no_image.png'
                    ? NetworkImage(
                        'https://tumbasonline.com/pasarmakmur/asset/foto_produk/${barang.gambar}')
                    : AssetImage('assets/baru2.png'),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    barang.namaProduk,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    barang.keterangan,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              Text(
                'Rp. ${barang.harga}',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: PopupMenuButton<int>(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.more_vert, color: Colors.grey, size: 20),
                  onSelected: (item) => handleClick(item, barang),
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(value: 0, child: Text('Edit')),
                    PopupMenuItem<int>(value: 1, child: Text('Hapus')),
                  ],
                ),
              ),
              Container(
                width: 85,
                height: 25,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      barang.aktif == 'Y' ? Color(0xFF68A29D) : colorses.orange,
                    ),
                    elevation: MaterialStateProperty.all(2),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    barang.aktif == 'Y' ? 'Tersedia' : 'Habis',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void handleClick(int item, DatumBarang barang) {
    switch (item) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditProductBarang(
              barang: barang,
            ),
          ),
        );
        break;
      case 1:
        break;
    }
  }
}
