import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:intl/intl.dart';
import 'package:tumbaso_warung/src/bloc/memberBloc.dart';
import 'package:tumbaso_warung/src/models/getSetoranModel.dart';
import 'package:tumbaso_warung/src/pref/preferences.dart';
import 'package:tumbaso_warung/src/ui/produkBarang.dart';
import 'package:tumbaso_warung/src/ui/produkMaem.dart';
import 'package:tumbaso_warung/src/ui/utils/colorses.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
  String nama;

  getSetoran() {
    getKdUser().then((kduser) {
      blocMember.getSetoranProduct(kduser);
    });
  }
  @override
  void initState() {
    getNama().then((value){
      if(mounted)
        setState(() {
          nama = value;
        });
    });
    getKdUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 80,
            width: MediaQuery.of(context).size.width,
            color: colorses.dasar,
          ),
          Container(
            height: 150,
            padding: EdgeInsets.only(left: 30),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: colorses.background,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(31),bottomRight: Radius.circular(31)),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [colorses.dasar, colorses.background]),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                      border: Border.all(width: 1,color: Colors.white),
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/iconw.png",
                          ),
                          fit: BoxFit.cover)),
                  width: 90,
                  height: 90,
                ),
                SizedBox(height: 8,),
                Text("Hallo $nama",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              ],
            ),
          ),
          SizedBox(height: 24,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 200),
                          child: ProdukMaem()));
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 3,
                          offset: Offset(3, 5), // Shadow position
                        ),
                      ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.fastfood_outlined,size: 30,),
                      SizedBox(height: 5,),
                      Text("Makanan")
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 200),
                          child: ProdukBarang()));
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 3,
                          offset: Offset(3, 5), // Shadow position
                        ),
                      ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_basket_outlined,size: 30),
                      SizedBox(height: 5,),
                      Text("Barang")
                    ],
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: StreamBuilder(
                stream: blocMember.listSetoran,
                builder: (context, AsyncSnapshot<GetSetoranModel> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.data.length,
                        itemBuilder: (BuildContext context, int i) {
                          return Card(
                            elevation: 5.0,
                            shadowColor: Colors.green,
                            color: Colors.green[50],
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Column(
                                    children: [
                                      Text('Setoran',
                                          style: TextStyle(
                                              color: Colors.grey[600], fontSize: 15, fontWeight: FontWeight.w400)),
                                      SizedBox(height: 5),
                                      Text(formatCurrency.format(snapshot.data.data[i].setorPenjual),
                                          style: TextStyle(color: Colors.green, fontSize: 15, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text('Tunggakan',
                                              style: TextStyle(
                                                  color: Colors.grey[600], fontSize: 15, fontWeight: FontWeight.w400)),
                                          SizedBox(height: 5),
                                          Text(formatCurrency.format(snapshot.data.data[i].tunggakanSetor),
                                              style:
                                              TextStyle(color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.refresh,
                                        ),
                                        color: Colors.green,
                                        splashColor: Colors.greenAccent,
                                        onPressed: () async {
                                          getSetoran();
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error);
                  } else {
                    return SizedBox();
                  }
                }),
          ),
        ],
      ),
    );
  }
}