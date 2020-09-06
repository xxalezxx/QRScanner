import 'dart:async';

import 'package:qrscanner/src/model/scan_model.dart';

class Validators {
  final validationGeo =
      StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
          handleData: (scans, sink) {
    final geoScans = scans.where((s) => s.type == 'geo').toList();
    sink.add(geoScans);
  });

  final validationHttp =
      StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
          handleData: (scans, sink) {
    final geoScans = scans.where((s) => s.type == 'http').toList();
    sink.add(geoScans);
  });
}
