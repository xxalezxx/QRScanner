import 'package:flutter/material.dart';
import 'package:qrscanner/src/model/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

openScan(BuildContext context, scan) async {
  if (scan.type == 'http') {
    if (await canLaunch(scan.value)) {
      await launch(scan.value);
    } else {
      throw 'Can not open the URL ${scan.value}';
    }
  } else {
    Navigator.pushNamed(context, 'map', arguments: scan);
  }
}
