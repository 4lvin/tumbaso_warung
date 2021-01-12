
import 'package:flutter/material.dart';
import 'package:tumbaso_warung/src/ui/utils/colorses.dart';

class WarungPage extends StatefulWidget {
  @override
  _WarungPageState createState() => _WarungPageState();
}

class _WarungPageState extends State<WarungPage> {
  bool onOff = false;
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
      link = colorses.kuning;
    }
    return link;
  }
  Color _close(){
    Color link = colorses.kuning;
    print(onOff);
    if(onOff == false){
      link = Colors.black;
    }
    return link;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 180,
              height: 180,
              child: Image.asset(_image()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    onOff = false;
                    setState(() {

                    });
                  },
                  child: Text(
                      'Open',
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
                      setState(() {

                      });
                    }
                ),
                GestureDetector(
                  onTap: (){
                    onOff = true;
                    setState(() {

                    });
                  },
                  child: Text(
                      'Close',
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
