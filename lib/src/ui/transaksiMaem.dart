import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toast/toast.dart';
import 'package:tumbaso_warung/src/bloc/memberBloc.dart';
import 'package:tumbaso_warung/src/models/getTransaksiModel.dart';
import 'package:tumbaso_warung/src/pref/preferences.dart';
import 'package:tumbaso_warung/src/ui/utils/colorses.dart';
import 'package:tumbaso_warung/src/ui/utils/timeago.dart';

class TransaksiMaem extends StatefulWidget {
  const TransaksiMaem({Key key}) : super(key: key);

  @override
  _TransaksiMaemState createState() => _TransaksiMaemState();
}

class _TransaksiMaemState extends State<TransaksiMaem> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final currencyFormatter = NumberFormat('#,##0.00', 'ID');

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));

    getEmail().then((value) {
      blocMember.getTransaksi(value, '0');
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    getEmail().then((value) {
      blocMember.getTransaksi(value, '0');
    });
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    getEmail().then((value) {
      blocMember.getTransaksi(value, '0');
    });
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaksi Makanan',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 10),
          Container(
            width: size.width,
            height: size.height * 0.64,
            child: StreamBuilder<GetTransaksiModel>(
              stream: blocMember.listTransaksi,
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.data.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.notifications_off,
                              color: Colors.grey,
                              size: 50,
                            ),
                            Text(
                              "Belum mempunyai Transaksi",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: false,
                      header: WaterDropMaterialHeader(
                        backgroundColor: colorses.dasar,
                      ),
                      controller: _refreshController,
                      onRefresh: _onRefresh,
                      onLoading: _onLoading,
                      child: ListView.builder(
                        itemCount: snapshot.data.data.length,
                        itemBuilder: (context, index) =>
                            buildItem(context, size, snapshot.data.data[index]),
                      ),
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(BuildContext context, Size size, Datum transaksi) {
    int count = transaksi.produk.length;
    int status = int.parse(transaksi.status.idStatusPesanan);
    // String date = TimeConvert.timeAgo(transaksi.waktuTransaksi);

    String textStatus = '';
    Color colorStatus = Colors.white;

    if (status == 3) {
      textStatus = 'Kurir Menuju Warung';
      colorStatus = Color(0xFFF75F5F);
    } else if (status == 4) {
      textStatus = 'Menuggu Pesanan Diproses';
      colorStatus = Color(0xFFF08B5E);
    } else if (status == 5) {
      textStatus = 'Telah Diproses';
      colorStatus = colorses.dasar;
    }

    return GestureDetector(
      onTap: () {
        detailPesanan(context, size, 1, transaksi);
      },
      child: Container(
        width: size.width,
        height: 70,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: colorses.dasar, width: 1),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.card_giftcard,
              size: 30,
              color: colorses.dasar,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Pembelian $count Barang',
                  style: TextStyle(fontSize: 14),
                ),
                // Text(
                //   date,
                //   style: TextStyle(fontSize: 10, color: Colors.grey),
                // ),
              ],
            ),
            Spacer(),
            Container(
              width: 110,
              height: 16,
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: colorStatus,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                textStatus,
                style: TextStyle(fontSize: 8, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // dialog Detail Pesanan

  Future<Object> trackingPesanan(Size size) {
    return showGeneralDialog(
      barrierLabel: "tracking",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(
            begin: Offset(0, 1),
            end: Offset(0, 0),
          ).animate(anim1),
          child: child,
        );
      },
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: size.width,
            height: size.height * 0.9,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Material(
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Icon(Icons.arrow_back),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Detail Pesanan',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  SvgPicture.asset(
                    "assets/delivery-man.svg",
                    semanticsLabel: 'Acme Logo',
                    height: 70,
                    width: 70,
                    color: colorses.dasar,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Status Pengiriman',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 40),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 20,
                              width: 20,
                              color: colorses.dasar,
                            ),
                          ),
                          Container(
                            height: 40,
                            child: VerticalDivider(
                              color: colorses.dasar,
                              thickness: 1,
                              indent: 4,
                              endIndent: 4,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 6),
                          Text(
                            '12 - Agustus - 2021 | 13:00',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Text(
                            'Paket sedang dalam perjalanan ke lokasi anda.',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 20,
                              width: 20,
                              color: colorses.dasar,
                            ),
                          ),
                          Container(
                            height: 40,
                            child: VerticalDivider(
                              color: colorses.dasar,
                              thickness: 1,
                              indent: 4,
                              endIndent: 4,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 6),
                          Text(
                            '12 - Agustus - 2021 | 13:00',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Text(
                            'Paket telah di kirim dari PURWOSARI tempat sortir.',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 20,
                          width: 20,
                          color: colorses.dasar,
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 6),
                          Text(
                            '12 - Agustus - 2021 | 13:00',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Text(
                            'Paket telah di trema oleh kurir jasa kirim JNT.',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<Object> detailPesanan(
      BuildContext context, Size size, int status, Datum transaksi) {
    int dProduk = 3;
    if (transaksi.produk.length < 3) {
      dProduk = transaksi.produk.length;
    }

    int total = 0;
    transaksi.produk.forEach((prod) {
      total += prod.harga;
    });

    return showGeneralDialog(
      barrierLabel: "detail",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(
            begin: Offset(0, 1),
            end: Offset(0, 0),
          ).animate(anim1),
          child: child,
        );
      },
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: size.width,
            height: size.height * 0.9,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Material(
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Icon(Icons.arrow_back),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Detail Pesanan',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              'https://img.icons8.com/bubbles/2x/user.png',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transaksi.pelanggan.namaPelanggan,
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '${transaksi.produk.length} menu | ${transaksi.kodeTransaksi}',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                "assets/delivery-man.svg",
                                semanticsLabel: 'Acme Logo',
                                height: 12,
                                width: 12,
                                color: Colors.grey[600],
                              ),
                              SizedBox(width: 6),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kurir penjemput makanan:',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    transaksi.detailPengiriman.kurir,
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Container(
                    width: size.width,
                    height: (60.0 * dProduk),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: transaksi.produk
                          .map((e) => detailPesananItem(size, e))
                          .toList(),
                    ),
                  ),
                  Container(
                    width: size.width,
                    height: 60,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 1,
                          color: Colors.black12,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Rp. Rp. ${currencyFormatter.format(total)}',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  SizedBox(height: 20),
                  status == 2
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: size.width * 0.3,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  shadowColor: MaterialStateProperty.all<Color>(
                                      Colors.white),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          width: 1.5, color: colorses.orange),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Habis',
                                  style: TextStyle(
                                      fontSize: 16, color: colorses.orange),
                                ),
                              ),
                            ),
                            Container(
                              width: size.width * 0.56,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(colorses.dasar),
                                  shadowColor: MaterialStateProperty.all<Color>(
                                      Colors.white),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Proses Pesanan',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  inputNoResi(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              height: 190,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 35,
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey[300]),
                        ),
                      ),
                      child: Text(
                        'Nomor Resi',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Masukkan Nomor Resi",
                        hintStyle: TextStyle(color: Colors.grey),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide(
                            color: Colors.grey[300],
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide(
                            color: Colors.grey[300],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 160.0,
                      height: 35,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(colorses.orange),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Text('Simpan'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget detailPesananItem(Size size, Produk pesanan) {
    int harga = pesanan.harga * int.parse(pesanan.qty);
    String image =
        'https://images.unsplash.com/photo-1624032545726-9d770c3615e7?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDJ8Sjl5clBhSFhSUVl8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60';
    if (image != '') {
      image =
          'https://jongjava.tech/tumbas/assets/foto_produk/' + pesanan.gambar1;
    }

    return Container(
      width: size.width,
      height: 60,
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: Colors.black12,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(image),
              ),
            ),
          ),
          SizedBox(width: 20),
          Container(
            // width: 160,
            child: Text(
              pesanan.namaProduk,
              style: TextStyle(fontSize: 14),
            ),
          ),
          Spacer(),
          Text(
            '${pesanan.qty}x',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(width: 20),
          Text(
            'Rp. Rp. ${currencyFormatter.format(harga)}',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
