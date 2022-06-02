// import 'package:intl/intl.dart';
// import 'package:flutter/material.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:toast/toast.dart';
// import 'package:tumbaso_warung/src/bloc/memberBloc.dart';
// import 'package:tumbaso_warung/src/bloc/produkPasmakBloc.dart';
// import 'package:tumbaso_warung/src/models/getBarangModel.dart';
// import 'package:tumbaso_warung/src/models/getKategoriBarangModel.dart';
// import 'package:tumbaso_warung/src/pref/preferences.dart';
// import 'package:tumbaso_warung/src/resources/globalApi.dart';
// import 'package:tumbaso_warung/src/ui/editProductBarang.dart';
// import 'package:tumbaso_warung/src/ui/newProductBarang.dart';
// import 'package:tumbaso_warung/src/ui/utils/colorses.dart';
//
// class ProdukBarang extends StatefulWidget {
//   ProdukBarang({this.kurir});
//   final String kurir;
//   @override
//   _ProdukBarangState createState() => _ProdukBarangState();
// }
//
// class _ProdukBarangState extends State<ProdukBarang> {
//   RefreshController _refreshController =
//       RefreshController(initialRefresh: false);
//   final currencyFormatter = NumberFormat('#,##0', 'id_ID');
//
//   GetKategoriBarangModel _listKategori;
//
//   void _onRefresh() async {
//     await Future.delayed(Duration(milliseconds: 1000));
//
//     blocProdukPasmak.getBarang();
//     _refreshController.refreshCompleted();
//   }
//
//   void _onLoading() async {
//     blocProdukPasmak.getBarang();
//     _refreshController.loadComplete();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     blocProdukPasmak.getBarang();
//     blocProdukPasmak.getKategoriBarang();
//     blocProdukPasmak.resKategori.listen((event) {
//       if (mounted)
//         setState(() {
//           _listKategori = event;
//         });
//     });
//   }
//
//   @override
//   void dispose() {
//     _refreshController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Produk Barang"),
//         backgroundColor: colorses.dasar,
//         elevation: 0,
//       ),
//       body: body(size),
//       floatingActionButton: Container(
//         width: 180,
//         height: 45,
//         child: ElevatedButton(
//           onPressed: () {
//             if (widget.kurir == null || widget.kurir == '') {
//               Toast.show("Anda harus melengkapi profil", context,
//                   duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//             } else {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => NewProductBarang()));
//             }
//           },
//           style: ButtonStyle(
//             backgroundColor: MaterialStateProperty.all(colorses.dasar),
//             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//               RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(25.0),
//               ),
//             ),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 "assets/dinner.png",
//                 width: 28,
//                 height: 28,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 8.0),
//                 child: Text(
//                   "Tambah menu",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget body(Size size) {
//     return Container(
//       width: size.width,
//       height: size.height,
//       // color: Colors.amber,
//       padding: EdgeInsets.symmetric(horizontal: 10),
//       child: StreamBuilder<GetBarangModel>(
//         stream: blocProdukPasmak.resBarang,
//         builder: (_, snapshot) {
//           if (snapshot.hasData) {
//             if (snapshot.data.data.isEmpty) {
//               return Padding(
//                 padding: const EdgeInsets.only(top: 18.0),
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Icon(
//                         Icons.notifications_off,
//                         color: Colors.grey,
//                         size: 50,
//                       ),
//                       Text(
//                         "Belum mempunyai Barang",
//                         style: TextStyle(color: Colors.grey),
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             } else {
//               return SmartRefresher(
//                 enablePullDown: true,
//                 enablePullUp: false,
//                 header: WaterDropMaterialHeader(
//                   backgroundColor: colorses.dasar,
//                 ),
//                 controller: _refreshController,
//                 onRefresh: _onRefresh,
//                 onLoading: _onLoading,
//                 child: GridView.builder(
//                   padding: EdgeInsets.only(top: 10),
//                   itemCount: snapshot.data.data.length,
//                   itemBuilder: (context, index) =>
//                       buildItem(size, snapshot.data.data[index]),
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 3 / 4.4,
//                     crossAxisSpacing: 18,
//                     mainAxisSpacing: 18,
//                   ),
//                 ),
//               );
//             }
//           } else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   Widget buildToko(Size size) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Container(
//           width: size.width,
//           height: 40,
//           margin: EdgeInsets.only(bottom: 40),
//           decoration: BoxDecoration(
//             color: colorses.dasar,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 3,
//                 offset: Offset(0, 3),
//               ),
//             ],
//           ),
//         ),
//         Container(
//           height: 60,
//           width: size.width * 0.9,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 3,
//                 offset: Offset(0, 3),
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               GestureDetector(
//                 onTap: () async {
//                   if (widget.kurir != '') {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => NewProductBarang()));
//                   } else {
//                     Toast.show("Anda harus melengkapi profil", context,
//                         duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//                   }
//                 },
//                 child: Container(
//                   width: (size.width / 3) - 28,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: colorses.orange,
//                             width: 2,
//                           ),
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(20),
//                           ),
//                         ),
//                         child: Icon(
//                           Icons.add,
//                           color: colorses.orange,
//                           size: 16,
//                         ),
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         'Tambah Produk',
//                         style: TextStyle(fontSize: 10),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               VerticalDivider(
//                 color: Colors.grey.shade300,
//                 thickness: 1,
//                 endIndent: 4,
//                 indent: 4,
//               ),
//               Container(
//                 width: (size.width / 3) - 28,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       '4,5',
//                       style: TextStyle(fontSize: 14),
//                     ),
//                     SizedBox(height: 2),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.star,
//                           color: Colors.yellow[600],
//                           size: 16,
//                         ),
//                         Icon(
//                           Icons.star,
//                           color: Colors.yellow[600],
//                           size: 16,
//                         ),
//                         Icon(
//                           Icons.star,
//                           color: Colors.yellow[600],
//                           size: 16,
//                         ),
//                         Icon(
//                           Icons.star,
//                           color: Colors.yellow[600],
//                           size: 16,
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       'Rating Toko',
//                       style: TextStyle(fontSize: 10),
//                     ),
//                   ],
//                 ),
//               ),
//               VerticalDivider(
//                 color: Colors.grey.shade300,
//                 thickness: 1,
//                 endIndent: 4,
//                 indent: 4,
//               ),
//               Container(
//                 width: (size.width / 3) - 28,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.share_outlined,
//                       color: colorses.orange,
//                     ),
//                     SizedBox(height: 4),
//                     Text(
//                       'Share',
//                       style: TextStyle(fontSize: 10),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget buildItem(Size size, DatumBarang barang) {
//     String kategori;
//     if (_listKategori != null) {
//       _listKategori.data.forEach((e) {
//         if (e.idKategori == barang.idKategoriProduk) {
//           kategori = e.namaKategori;
//         }
//       });
//     }
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 6,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             children: [
//               Container(
//                 width: ((size.width / 2) - 20),
//                 height: ((size.width / 2) - 40),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(10),
//                     topRight: Radius.circular(10),
//                   ),
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: '${globalBarang}/asset/foto_produk/${barang.gambar}' !=
//                             '${globalBarang}/asset/foto_produk/no_image.png'
//                         ? NetworkImage(
//                             '${globalBarang}/asset/foto_produk/${barang.gambar}')
//                         : AssetImage('assets/baru2.png'),
//                   ),
//                 ),
//               ),
//               barang.aktif == 'Y'
//                   ? Container()
//                   : Container(
//                       alignment: Alignment.center,
//                       width: ((size.width / 2) - 20),
//                       height: ((size.width / 2) - 40),
//                       decoration: BoxDecoration(
//                         color: Colors.white70,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(10),
//                           topRight: Radius.circular(10),
//                         ),
//                       ),
//                       child: Container(
//                         alignment: Alignment.center,
//                         width: size.width / 5,
//                         height: size.width / 5,
//                         decoration: BoxDecoration(
//                           color: Colors.black45,
//                           borderRadius: BorderRadius.circular(60),
//                         ),
//                         child: Text(
//                           'Habis',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//               Align(
//                 alignment: Alignment.topRight,
//                 child: GestureDetector(
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => EditProductBarang(barang: barang),
//                     ),
//                   ),
//                   child: Container(
//                     width: 30,
//                     height: 30,
//                     margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.90),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.topRight,
//                 child: PopupMenuButton<int>(
//                   icon: Icon(Icons.edit),
//                   onSelected: (item) => handleClick(item, barang),
//                   itemBuilder: (context) => [
//                     PopupMenuItem<int>(value: 0, child: Text('Edit')),
//                     PopupMenuItem<int>(value: 1, child: Text('Status')),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             height: size.height * 0.1,
//             width: (size.width / 2) - 20,
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   kategori == null ? 'Kategori' : kategori,
//                   style: TextStyle(
//                     color: colorses.orange,
//                     fontSize: 10,
//                   ),
//                 ),
//                 Text(
//                   barang.namaProduk,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     fontSize: 12,
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       width: size.width * 0.3,
//                       child: Text(
//                         'Rp. ${currencyFormatter.format(int.parse(barang.harga))}',
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 1,
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     Spacer(),
//                     Icon(
//                       Icons.star,
//                       size: 15,
//                       color: Colors.yellow[600],
//                     ),
//                     Text(
//                       '4,5',
//                       style: TextStyle(fontSize: 8),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void handleClick(int item, DatumBarang barang) {
//     switch (item) {
//       case 0:
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => EditProductBarang(
//               barang: barang,
//             ),
//           ),
//         );
//         break;
//       case 1:
//         blocProdukPasmak.updateStatusBarang(
//             barang.idProduk, barang.aktif == 'Y' ? 'N' : 'Y');
//         _onRefresh();
//         break;
//     }
//   }
// }
