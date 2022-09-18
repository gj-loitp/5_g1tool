import 'package:g1tool/model/player.dart';
import 'package:get/get.dart';

import '../common/db/db_provider.dart';

class ListPlayerController extends GetxController {
  var listPlayer = <Player>[].obs;

  void getListPlayer() async {
    var list = await DBProvider.db.getAllPlayer();
    listPlayer.clear();
    listPlayer.addAll(list);
    listPlayer.refresh();
    // print(">>>getListPlayer ${listPlayer.length}");
  }

  Future<void> genListPlayerDefault() async {
    Future<void> addPlayer(String name, String avatar) async {
      Player player = Player();
      player.name = name;
      player.avatar = avatar;
      if (!isExistPlayer(player)) {
        listPlayer.add(player);
        await DBProvider.db.addClient(player);
      }
    }

    addPlayer("Trần Phú Lợi", "");
    addPlayer("Toại *||*", "");
    addPlayer("Phúc (|)", "");
    addPlayer("Bảo Chu", "");
    addPlayer("Duy", "");
    addPlayer("Linh", "");
    addPlayer("Ngân", "");
    addPlayer("Chi", "");
    addPlayer("Viên", "");
    addPlayer("Tú", "");
    addPlayer("Huyền", "");
    addPlayer("Bảo Huỳnh", "");
    addPlayer("Huy", "");
    addPlayer("Tịnh", "");
    addPlayer("Triển", "");
    listPlayer.refresh();
  }

  bool isExistPlayer(Player player) {
    bool isExist = false;
    for (var p in listPlayer) {
      if (player.name == p.name && player.avatar == p.avatar) {
        isExist = true;
      }
    }
    return isExist;
  }
}
