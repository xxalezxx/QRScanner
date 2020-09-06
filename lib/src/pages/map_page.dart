import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qrscanner/src/model/scan_model.dart';

class MapPage extends StatelessWidget {
  final MapController mapController = MapController();
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
          'id': 'mapbox.outdoors' //street, dark, light, outdoors, satellite,
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
}
