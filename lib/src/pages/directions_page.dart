import 'package:flutter/material.dart';
import 'package:qrscanner/src/block/scans_block.dart';
import 'package:qrscanner/src/model/scan_model.dart';
import 'package:qrscanner/src/providers/db_provider.dart';

import 'package:qrscanner/src/utils/utils.dart' as utils;

class DirectionsPage extends StatelessWidget {
  final scanBlock = new ScansBlock();
  @override
  Widget build(BuildContext context) {
    scanBlock.getScans();
    return StreamBuilder<Object>(
        stream: scanBlock.scansStreamHttp,
        builder: (context, snapshot) {
          return FutureBuilder<List<ScanModel>>(
            future: DBProvider.db.getTodosScans(),
            builder: (BuildContext context,
                AsyncSnapshot<List<ScanModel>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final scans = snapshot.data;
              if (scans.length == 0) {
                return Center(
                  child: Text("There is not information"),
                );
              }
              return ListView.builder(
                  itemCount: scans.length,
                  itemBuilder: (context, index) => Dismissible(
                      key: UniqueKey(),
                      background: Container(
                        color: Colors.red,
                      ),
                      secondaryBackground: Container(
                        color: Colors.amber,
                      ),
                      onDismissed: (direction) =>
                          scanBlock.deleteScan(scans[index].id),
                      child: ListTile(
                        onTap: () => utils.openScan(context, scans[index]),
                        leading: Icon(Icons.cloud_queue),
                        title: Text(scans[index].value),
                        subtitle: Text("${scans[index].id}"),
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.blue,
                        ),
                      )));
            },
          );
        });
  }
}
