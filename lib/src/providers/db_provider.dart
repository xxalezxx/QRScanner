import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';
import 'package:qrscanner/src/model/scan_model.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'ScansDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE  Scans ('
            'id INTEGER PRIMARY KEY,'
            'tipe TEXT,'
            'value TEXT'
            ')');
      },
    );
  }

// One model to insert
  newScanRaw(ScanMode newScan) async {
    final db = await database;
    final resp = await db.rawInsert("INSERT into Scans (is, type, value) "
        "VALUES (${newScan.id}, ${newScan.type}, ${newScan.value} ");

    return resp;
  }

// Second model to insert
  newScan(ScanMode newScan) async {
    final db = await database;
    final resp = db.insert('Scans', newScan.toJson());
    return resp;
  }
}
