import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qrscanner/src/model/scan_model.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController mapController = MapController();

  int indexTypeMap = 0;
  String actualMap = 'dark';
  List<String> typeMaps = [
    'streets',
    'dark',
    'light',
    'ouutdoors',
    'satellite',
  ];

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Coordenates QR"),
        actions: [
          IconButton(
              icon: Icon(Icons.my_location),
              onPressed: () {
                mapController.move(scan.getLatLng(), 15);
              })
        ],
      ),
      body: _createFlutterMap(scan),
      floatingActionButton: _createFloatingButton(context),
    );
  }

  Widget _createFlutterMap(ScanModel scan) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 10,
      ),
      layers: [
        _createMap(),
        _createMarks(scan),
      ],
    );
  }

  _createMap() {
    return TileLayerOptions(
        urlTemplate: 'https://api.tiles.mapbox.com/v4/'
            '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
        additionalOptions: {
          'accessToken':
              'pk.eyJ1Ijoiam9yZ2VncmVnb3J5IiwiYSI6ImNrODk5aXE5cjA0c2wzZ3BjcTA0NGs3YjcifQ.H9LcQyP_-G9sxhaT5YbVow',
          'id': 'mapbox.$actualMap' //street, dark, light, outdoors, satellite,
        });
  }

  _createMarks(scan) {
    return MarkerLayerOptions(markers: <Marker>[
      Marker(
        width: 100.0,
        height: 100.0,
        point: scan.getLatLng(),
        builder: (context) => Container(
          child: Icon(
            Icons.location_on,
            size: 70.0,
            color: Theme.of(context).primaryColor,
          ),
        ),
      )
    ]);
  }

  Widget _createFloatingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (indexTypeMap < typeMaps.length - 1) {
          indexTypeMap++;
          actualMap = typeMaps[indexTypeMap];
        } else {
          indexTypeMap = 0;
          actualMap = typeMaps[indexTypeMap];
        }
        setState(() {
          print('->$indexTypeMap & map es:$actualMap');
        });
      },
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
