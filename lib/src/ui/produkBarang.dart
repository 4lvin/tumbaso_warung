import 'package:flutter/material.dart';
import 'package:tumbaso_warung/src/ui/newProductBarang.dart';
import 'package:tumbaso_warung/src/ui/utils/colorses.dart';

class ProdukBarang extends StatefulWidget {

  @override
  _ProdukBarangState createState() => _ProdukBarangState();
}

class _ProdukBarangState extends State<ProdukBarang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Produk Barang"),
        backgroundColor: colorses.dasar,
      ),
        floatingActionButton: new FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewProductBarang()),
            );
          },
          child: const Icon(Icons.add),
        )
    );
  }
}
