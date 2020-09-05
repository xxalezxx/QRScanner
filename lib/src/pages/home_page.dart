import 'package:barcode_scan/barcode_scan.dart';

import 'package:flutter/material.dart';
import 'package:qrscanner/src/model/scan_model.dart';

import 'package:qrscanner/src/pages/directions_page.dart';
import 'package:qrscanner/src/pages/maps.dart';
import 'package:qrscanner/src/providers/db_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currectIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _callPage(currectIndex),
      bottomNavigationBar: _createBottonNavigatorBar(),
      floatingActionButton: _floatingButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _createBottonNavigatorBar() {
    return BottomNavigationBar(
      currentIndex: currectIndex,
      onTap: (index) {
        setState(() {
          currectIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Map')),
        BottomNavigationBarItem(
            icon: Icon(Icons.brightness_5), title: Text('Directions')),
      ],
    );
  }

  Widget _callPage(int actualPage) {
    switch (actualPage) {
      case 0:
        return MapsPage();
        break;
      case 1:
        return DirectionsPage();
        break;
      default:
        return MapsPage();
    }
  }

  Widget _floatingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: _scanQR,
      child: Icon(Icons.filter_center_focus),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  Widget _appBar() {
    return AppBar(
      centerTitle: true,
      title: Text('QR Scanner'),
      actions: [IconButton(icon: Icon(Icons.delete_forever), onPressed: () {})],
    );
  }

  _scanQR() async {
// test
    // https://fernando-herrera.com/#/home

    var futureString;

    String test = 'https://fernando-herrera.com/#/home';

    // try {
    //   futureString = await BarcodeScanner.scan();
    // } catch (e) {
    //   futureString = e.toString();
    // }

    // print(futureString.rawContent);

    final scan = ScanModel(value: test);
    DBProvider.db.nuevoScanRaw(scan);
  }
}
