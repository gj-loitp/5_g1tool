import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:g1tool/model/player.dart';
import 'package:get/get.dart';

import '../../common/db/db_provider.dart';
import '../../model/bilac.dart';

class BilacMainController extends GetxController {
  var bilac = Bilac().obs;

  void _print(String s) {
    if (kDebugMode) {
      print(s);
    }
  }

  void getBilacByTime(String time) async {
    // _print(">>>getBilacByTime $time");
    var b = await DBProvider.db.getBilacByTime(time);
    if (b != null) {
      bilac.value = b;
    }
    _print(">>>getBilacByTime $time -> bilac ${jsonEncode(bilac)}");
  }

  void genNewSession(List<Player> listPlayerSelected) {
    Session session = Session();
    session.time = DateTime.now().toIso8601String();
  }
}
