import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:tumbaso_warung/src/ui/HomePage.dart';
import 'package:tumbaso_warung/src/ui/historyPage.dart';
import 'package:tumbaso_warung/src/ui/transaksi.dart';
import 'package:tumbaso_warung/src/ui/utils/colorses.dart';
import 'package:tumbaso_warung/src/ui/warung.dart';

// ignore: must_be_immutable
class ControllerPage extends StatefulWidget {
  ControllerPage({this.selected});
  int selected;
  @override
  _ControllerPageState createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  int _selectedIndex;
  bool _selectedTransakasi = false;
  String tipe;
  final PageStorageBucket bucket = PageStorageBucket();
  DateTime currentBackPressTime;

  final List<Widget> _widgetOptions = [
    HomePage(),
    TransaksiPage(),
    HistoryPage(),
    WarungPage()
  ];

  final List<Widget> _widgetOptions2 = [
    HomePage(),
    TransaksiPage(selected: 1),
    HistoryPage(),
    WarungPage()
  ];

  Future<bool> _onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Toast.show("Tekan sekali lagi untuk keluar", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return Future.value(false);
    }
    return Future.value(true);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    widget.selected == null
        ? _selectedIndex = 0
        : _selectedIndex = widget.selected;
    _onActionNotif();
    super.initState();
  }

  _onActionNotif() {
    AwesomeNotifications().displayedStream.listen((event) {
      if (event.channelKey == 'barang_channel') {
        _selectedTransakasi = true;
        _selectedIndex = 1;
        setState(() {});
      }
      if (event.channelKey == 'maem_channel') {
        _selectedTransakasi = false;
        _selectedIndex = 1;
        setState(() {});
      }
      if (event.channelKey == 'awesome_channel') {
        _selectedTransakasi = false;
        _selectedIndex = 0;
        setState(() {});
      }
    });

    AwesomeNotifications().actionStream.listen((event) {
      if (event.channelKey == 'barang_channel') {
        _selectedTransakasi = true;
        _selectedIndex = 1;
        setState(() {});
      }
      if (event.channelKey == 'maem_channel') {
        _selectedTransakasi = false;
        _selectedIndex = 1;
        setState(() {});
      }
      if (event.channelKey == 'awesome_channel') {
        _selectedTransakasi = false;
        _selectedIndex = 0;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().displayedSink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
          child: PageStorage(
            bucket: bucket,
            child: _selectedTransakasi
                ? _widgetOptions2[_selectedIndex]
                : _widgetOptions[_selectedIndex],
          ),
          onWillPop: _onWillPop),
      bottomNavigationBar: FloatingNavbar(
        // type: BottomNavigationBarType.fixed,
        items: [
          FloatingNavbarItem(
            customWidget: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 2,
                  color: Colors.white,
                ),
              ),
              child: Icon(
                Icons.home,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
          FloatingNavbarItem(
            customWidget: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 2,
                  color: Colors.white,
                ),
              ),
              child: Icon(
                Icons.confirmation_number,
                size: 36,
                color: Colors.white,
              ),
            ),
          ),
          FloatingNavbarItem(
            customWidget: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 2,
                  color: Colors.white,
                ),
              ),
              child: Icon(
                Icons.history,
                size: 36,
                color: Colors.white,
              ),
            ),
          ),
          FloatingNavbarItem(
            customWidget: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 2,
                  color: Colors.white,
                ),
              ),
              child: Icon(
                Icons.person,
                size: 36,
                color: Colors.white,
              ),
            ),
          ),
        ],
        borderRadius: 12,
        // elevation: 16,
        unselectedItemColor: const Color(0xFFbdbfbe),
        backgroundColor: colorses.dasar,
        selectedBackgroundColor: colorses.orange,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
