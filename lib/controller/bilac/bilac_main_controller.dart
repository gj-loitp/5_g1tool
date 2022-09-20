import 'package:flutter/foundation.dart';
import 'package:g1tool/model/player.dart';
import 'package:get/get.dart';

class BilacMainController extends GetxController {
  void _print(String s) {
    if (kDebugMode) {
      print(s);
    }
  }

  void genNewGame(List<Player> listPlayerSelected) {}
}
