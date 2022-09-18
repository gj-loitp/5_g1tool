import 'dart:convert';

import 'package:g1tool/model/player.dart';
import 'package:get/get.dart';

import '../common/db/db_provider.dart';

class AddPlayerController extends GetxController {
  var listPlayer = <Player>[].obs;
  var name = "".obs;

  void setName(String s) {
    name.value = s;
  }

  bool isValidName() {
    return name.value.isNotEmpty;
  }

  void getListPlayer() async {
    var list = await DBProvider.db.getAllPlayer();
    listPlayer.assignAll(list);
    print(">>>listPlayer " + jsonEncode(listPlayer));
  }

  void addPlayer(String name) async {
    Player p = Player();
    p.name = name;
    p.avatar =
        "https://live.staticflickr.com/8051/28816266454_a7d83db3b2_w.jpg";
    print('p ${p.toJson()}');

    await DBProvider.db.addClient(p);

    getListPlayer();
  }
}
