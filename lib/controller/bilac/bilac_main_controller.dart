import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:g1tool/common/c/time_constant.dart';
import 'package:g1tool/model/bilac.dart';
import 'package:g1tool/model/player.dart';
import 'package:get/get.dart';

import '../../common/db/db_provider.dart';

class BilacMainController extends GetxController {
  var isShowCalendar = true.obs;
  var selectedDatetime = DateTime.now().obs;
  var listBilac = <Bilac>[].obs;

  // var listPlayer = <Player>[].obs;
  var scoreSelector = Player.RESULT_NONE.obs;

  void _print(String s) {
    if (kDebugMode) {
      print(s);
    }
  }

  void toggleShowCalendar() {
    isShowCalendar.value = !isShowCalendar.value;
  }

  void setSelectedDatetime(DateTime dateTime) {
    selectedDatetime.value = dateTime;
  }

  Future<void> genNewGame(List<Player> listPlayerSelected) async {
    //TODO fix loi khi add new game se bi duplicate bilac
    var bilac = Bilac();
    bilac.time = TimeConstants.getTime(selectedDatetime.value);

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

    // _print(">>>listPlayer ${jsonEncode(listPlayer)}");
    bilac.setListPlayer(listPlayer);

    _print(">>>this.bilac ${jsonEncode(bilac)}");
    listBilac.add(bilac);

    for (var bilac in listBilac) {
      await DBProvider.db.addBilac(bilac);
    }
    getBilacByTime();
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

  Future<void> updateScoreOfPlayer(
    int indexBilac,
    List<Player> listPlayer,
    int indexScore,
    Player player,
    String newScore,
  ) async {
    // _print(">>>_onTap index $indexScore - ${jsonEncode(player)}");
    player.updateScoreByIndex(indexScore, newScore);
    listBilac[indexBilac].setListPlayer(listPlayer);
    listBilac.refresh();
    await DBProvider.db.updateBilac(listBilac[indexBilac]);
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

  Future<void> getBilacByTime() async {
    String time = TimeConstants.getTime(selectedDatetime.value);
    var list = await DBProvider.db.getBilacByTime(time);
    // _print("time $time -> b: ${jsonEncode(b)}");

    listBilac.clear();
    for (var bl in list) {
      listBilac.add(bl);
    }
    listBilac.refresh();
  }

  List<Player> getListPlayer(int index) {
    return listBilac[index].getListPlayer();
  }
}
