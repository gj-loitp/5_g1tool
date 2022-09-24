import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:g1tool/common/c/time_constant.dart';
import 'package:g1tool/model/bilac.dart';
import 'package:g1tool/model/player.dart';
import 'package:get/get.dart';

import '../../common/db/db_provider.dart';

class BilacMainController extends GetxController {
  var bilac = Bilac().obs;

  // var listPlayer = <Player>[].obs;
  var scoreSelector = Player.RESULT_NONE.obs;

  void _print(String s) {
    if (kDebugMode) {
      print(s);
    }
  }

  Future<void> genNewGame(List<Player> listPlayerSelected) async {
    var bilac = Bilac();
    bilac.time = TimeConstants.getTime(DateTime.now());

    var listPlayer = <Player>[];
    listPlayer.addAll(listPlayerSelected);

    var maxRound = getMaxRound(listPlayerSelected.length);
    String tmpScoreString = Player.RESULT_NONE;
    for (int i = 0; i < maxRound - 1; i++) {
      tmpScoreString += "#${Player.RESULT_NONE}";
    }
    for (var p in listPlayer) {
      p.scoreString = tmpScoreString;
    }

    _print(">>>listPlayer ${jsonEncode(listPlayer)}");
    bilac.setListPlayer(listPlayer);

    _print(">>>this.bilac ${jsonEncode(bilac)}");
    this.bilac.value = bilac;

    await DBProvider.db.addBilac(this.bilac.value);
    getBilacByTime(TimeConstants.getTime(DateTime.now()));
  }

  //tinh to hop n chap k
  int C(int k, int n) {
    if (k == 0 || k == n) return 1;
    if (k == 1) return n;
    return C(k - 1, n - 1) + C(k, n - 1);
  }

  int getMaxRound(int listLength) {
    return C(2, listLength);
  }

  void updateScoreOfPlayer(int indexScore, Player player, String newScore) {
    // _print(">>>_onTap index $indexScore - ${jsonEncode(player)}");
    // player.updateScoreByIndex(indexScore, newScore);
    // listPlayer.refresh();

    //TODO
  }

  void setScoreSelector(String s) {
    scoreSelector.value = s;
  }

  String getScoreSelectorText() {
    String s = "Mặc định";
    if (scoreSelector.value == Player.RESULT_WIN) {
      s = "Thắng";
    } else if (scoreSelector.value == Player.RESULT_LOSE) {
      s = "Thua";
    }
    return s;
  }

  Color getScoreSelectorColor() {
    return Player.getColorByScore(scoreSelector.value);
  }

  Future<void> getBilacByTime(String time) async {
    var b = await DBProvider.db.getBilacByTime(time);
    // _print("time $time -> b: ${jsonEncode(b)}");
    if (b == null) {
      bilac.value = Bilac();
    }else{
      bilac.value = b;
    }
    // _print(">>>getBilacByTime time $time -> ${jsonEncode(bilac.value)}");
    // _print(">>>getListPlayer ${jsonEncode(bilac.value.getListPlayer())}");
  }

  bool isEmptyData() {
    if (bilac.value.time == null || bilac.value.time?.isEmpty == true) {
      return true;
    } else {
      return false;
    }
  }

  List<Player> getListPlayer() {
    return bilac.value.getListPlayer();
  }
}
