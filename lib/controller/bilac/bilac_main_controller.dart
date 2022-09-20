import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:g1tool/model/player.dart';
import 'package:get/get.dart';

class BilacMainController extends GetxController {
  var listPlayer = <Player>[].obs;

  void _print(String s) {
    if (kDebugMode) {
      print(s);
    }
  }

  void genNewGame(List<Player> listPlayerSelected) {
    listPlayer.clear();
    listPlayer.addAll(listPlayerSelected);

    var maxRound = getMaxRound();
    String tmpScoreString = "";
    for (int i = 0; i < maxRound - 1; i++) {
      tmpScoreString += "#${Player.RESULT_NONE}";
    }
    for (var p in listPlayer) {
      p.scoreString = tmpScoreString;
    }

    // _print(">>>listPlayer ${jsonEncode(listPlayer)}");
    listPlayer.refresh();
  }

  //tinh to hop n chap k
  int C(int k, int n) {
    if (k == 0 || k == n) return 1;
    if (k == 1) return n;
    return C(k - 1, n - 1) + C(k, n - 1);
  }

  int getMaxRound() {
    // _print("getMaxRound ${C(2, listPlayer.length)}");
    return C(2, listPlayer.length);
  }

  void updateScoreOfPlayer(int indexScore, Player player, String newScore) {
    _print(">>>_onTap index $indexScore - ${jsonEncode(player)}");
    player.updateScoreByIndex(indexScore, newScore);
    listPlayer.refresh();
  }
}
