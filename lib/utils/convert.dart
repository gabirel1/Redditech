import 'dart:convert';

import 'package:flutter/services.dart';

String timestampToString(double timestamp) {
  var now = DateTime.now();
  var difference = now
      .difference(DateTime.fromMillisecondsSinceEpoch(timestamp.toInt() * 1000))
      .inSeconds;
  // print("diff = $difference");
  if (difference < 60) {
    return 'Now';
  } else if (difference < 3600) {
    return '${difference ~/ 60}m';
  } else if (difference < 86400) {
    return '${difference ~/ 3600}h';
  } else {
    return '${difference ~/ 86400}d';
  }
}

Future<List> getCountryCodeNameList() async {
  List list = [];
  var jsonFile = await rootBundle.loadString('assets/countries.json');
  var countries = jsonDecode(jsonFile);

  for (var country in countries) {
    list.add({"name": country['name'], "code": country['code']});
  }
  return list;
}

Future<String> getCountryNameFromCountryCode(String countreCode) async {
  var jsonFile = await rootBundle.loadString('assets/countries.json');
  var countries = jsonDecode(jsonFile);
  for (var country in countries) {
    if (country['code'] == countreCode) {
      return country['name'];
    }
  }
  return "";
}
