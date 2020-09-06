import 'dart:async';

import 'package:qrscanner/src/block/validator.dart';
import 'package:qrscanner/src/model/scan_model.dart';
import 'package:qrscanner/src/providers/db_provider.dart';

class ScansBlock with Validators {
  static final ScansBlock _singleton = new ScansBlock._internal();

  factory ScansBlock() {
    return _singleton;
  }
  ScansBlock._internal() {
    getScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream =>
      _scansController.stream.transform(validationGeo);
  Stream<List<ScanModel>> get scansStreamHttp =>
      _scansController.stream.transform(validationHttp);

  dispose() {
    _scansController?.close();
  }

  getScans() async {
    _scansController.sink.add(await DBProvider.db.getTodosScans());
  }

  addScan(ScanModel newScan) async {
    await DBProvider.db.nuevoScan(newScan);
    getScans();
  }

  deleteScan(int id) async {
    await DBProvider.db.deleteScan(id);
    getScans();
  }

  deleteScanAll() async {
    await DBProvider.db.deleteAll();
    getScans();
  }
}
