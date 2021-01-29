
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:tumbaso_warung/src/bloc/memberBloc.dart';
import 'package:tumbaso_warung/src/pref/preferences.dart';
import 'package:tumbaso_warung/src/ui/utils/colorses.dart';

class WarungPage extends StatefulWidget {
  @override
  _WarungPageState createState() => _WarungPageState();
}

class _WarungPageState extends State<WarungPage> {
  bool onOff = false;
  String nama;
  String token;
  String username;
  String _image(){
    String link = "assets/close.png";
    if(onOff == false){
      link = "assets/open.png";
    }
    return link;
  }
  Color _open(){
    Color link = Colors.black;
    if(!onOff){
      link = Colors.green;
    }
    return link;
  }
  Color _close(){
    Color link = Colors.black;
    print(onOff);
    if(onOff == false){
      link = Colors.black;
    }else{
      link = Colors.red;
    }
    return link;
  }

  @override
  void initState() {
    getToken().then((value){
      print(value);
      if(mounted)
      setState(() {
        token = value;
      });
    });
    getUsername().then((value){
      if(mounted)
        setState(() {
          username = value;
        });
    });
    getKdUser().then((value){
      blocMember.status(value);
    });
    blocMember.getStatus.listen((event) {
      if(mounted)
      setState(() {
        nama = event.data[0].nama;
      });
      if(event.data[0].aktif=="1"){
        if(mounted)
        setState(() {
          onOff = false;
        });
      }else{
        if(mounted)
        setState(() {
          onOff = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: nama == null? Center(child: CircularProgressIndicator()):Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("$nama",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            Container(
              width: 180,
              height: 180,
              child: Image.asset(_image(),color: onOff?Colors.red:Colors.green,),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){

                    blocMember.updateStatusToko(username, "1", token);
                    blocMember.resStatusToko.listen((event) {
                      if(event.status){
                        setState(() {
                          onOff = false;
                        });
                      }
                    });
                  },
                  child: Text(
                      'Buka',
                    style: TextStyle(
                      fontSize: 40,
                        color: _open()
                    ),
                  ),
                ),
                Switch(
                    activeColor: colorses.dasar,
                    inactiveTrackColor: colorses.kuning,
                    value: onOff,
                    onChanged: (newValue){
                      onOff = newValue;
                      if(newValue){
                        blocMember.updateStatusToko(username, "0", token);
                        blocMember.resStatusToko.listen((event) {
                          if(event.status){
                            Toast.show("Toko berhasil di Tutup", context,
                                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                          }
                        });
                      }else{
                        blocMember.updateStatusToko(username, "1", token);
                        blocMember.resStatusToko.listen((event) {
                          if(event.status){
                            Toast.show("Toko berhasil di Buka", context,
                                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                          }
                        });
                      }
                      setState(() {

                      });
                    }
                ),
                GestureDetector(
                  onTap: (){
                    blocMember.updateStatusToko(username, "0", token);
                    blocMember.resStatusToko.listen((event) {
                      if(event.status){
                        setState(() {
                          onOff = true;
                        });
                      }
                    });
                  },
                  child: Text(
                      'Tutup',
                    style: TextStyle(
                      fontSize: 40,
                      color: _close()
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
