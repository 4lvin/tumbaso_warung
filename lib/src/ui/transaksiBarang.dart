import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tumbaso_warung/src/ui/utils/colorses.dart';

class TransaksiBarang extends StatefulWidget {
  const TransaksiBarang({Key key}) : super(key: key);

  @override
  _TransaksiBarangState createState() => _TransaksiBarangState();
}

class _TransaksiBarangState extends State<TransaksiBarang> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hari ini',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                buildItem(context, size, 2, 'Baru saja', 1),
                buildItem(context, size, 5, '1 Jam yang lalu', 2),
                buildItem(context, size, 1, '4 Jam yang lalu', 3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(
      BuildContext context, Size size, int count, String date, int status) {
    String textStatus;
    Color colorStatus;
    if (status == 1) {
      textStatus = 'Menuggu di kemas';
      colorStatus = Color(0xFFF75F5F);
    } else if (status == 2) {
      textStatus = 'Menuggu input resi';
      colorStatus = Color(0xFFF08B5E);
    } else if (status == 3) {
      textStatus = 'Dalam Perjalanan';
      colorStatus = colorses.dasar;
    }
    return GestureDetector(
      onTap: () {
        if (status == 1) {
          detailPesanan(context, size, 1);
        } else if (status == 2) {
          detailPesanan(context, size, 2);
        } else if (status == 3) {
          trackingPesanan(size);
        }
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
                Text(
                  date,
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
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
      barrierLabel: "Label",
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

  Future<Object> detailPesanan(BuildContext context, Size size, int status) {
    return showGeneralDialog(
      barrierLabel: "Label",
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
                                'https://images.unsplash.com/photo-1629996734437-7217ae43bb55?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=80'),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Imam Pradana',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '3 menu | 12-08-2021 13:37',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.add_location,
                                size: 18,
                              ),
                              SizedBox(width: 6),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 240,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '+6281234567890',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        Text(
                                          'Imam Pradana',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        Text(
                                          'No. 26 Dsn. Kembang Kuning Rt. 001/Rw.001 Ds. Pandean Kec. Purwosari Kab. Pasuruan 67163',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.copy,
                                    color: colorses.orange,
                                    size: 18,
                                  )
                                ],
                              ),
                            ],
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
                                    'Pengiriman yang di Pilih:',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    'Ninja Express',
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
                    height: (60.0 * 3),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        detailPesananItem(size),
                        detailPesananItem(size),
                        detailPesananItem(size),
                      ],
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
                          'Rp. 6.000.000',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width,
                    height: 130,
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300], width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/delivery-man.svg",
                          semanticsLabel: 'Acme Logo',
                          height: 34,
                          width: 34,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Kirimkan pesanan ke jasa pengiriman sebelum Senin, 15 - 08 - 2021',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  status == 1
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 100,
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
                              width: 240,
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
                                  'Telah di kemas',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        )
                      : Container(
                          width: size.width,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () => inputNoResi(context),
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
                              'Masukkan No. Resi',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
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

  Widget detailPesananItem(Size size) {
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
                image: NetworkImage(
                    'https://images.unsplash.com/photo-1624032545726-9d770c3615e7?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDJ8Sjl5clBhSFhSUVl8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60'),
              ),
            ),
          ),
          SizedBox(width: 20),
          Container(
            width: 160,
            child: Text(
              'Laptop Hp X221 Core i5',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Spacer(),
          Text(
            '1x',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(width: 20),
          Text(
            'Rp. 2.000.000',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
