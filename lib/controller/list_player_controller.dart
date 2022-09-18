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

    addPlayer("Trần Phú Lợi", "https://github.com/tplloi/g1tool/blob/master/assets/images/player/loi.jpg?raw=true");
    addPlayer("Toại *||*", "https://github.com/tplloi/g1tool/blob/master/assets/images/player/toai.jpeg?raw=true");
    addPlayer("Phúc (|)", "https://github.com/tplloi/g1tool/blob/master/assets/images/player/phuc.jpg?raw=true");
    addPlayer("Bảo Chu", "https://github.com/tplloi/g1tool/blob/master/assets/images/player/baochu.jpg?raw=true");
    addPlayer("Duy", "https://github.com/tplloi/g1tool/blob/master/assets/images/player/duy.jpg?raw=true");
    addPlayer("Linh", "https://github.com/tplloi/g1tool/blob/master/assets/images/player/linh.jpg?raw=true");
    addPlayer("Ngân", "https://github.com/tplloi/g1tool/blob/master/assets/images/player/ngan.jpg?raw=true");
    addPlayer("Chi", "https://github.com/tplloi/g1tool/blob/master/assets/images/player/chi.jpg?raw=true");
    addPlayer("Viên", "https://github.com/tplloi/g1tool/blob/master/assets/images/player/vien.jpg?raw=true");
    addPlayer("Tú", "https://github.com/tplloi/g1tool/blob/master/assets/images/player/tu.jpg?raw=true");
    addPlayer("Huyền", "https://github.com/tplloi/g1tool/blob/master/assets/images/player/huyen.jpg?raw=true");
    addPlayer("Bảo Huỳnh", "https://github.com/tplloi/g1tool/blob/master/assets/images/player/baohuynh.jpg?raw=true");
    addPlayer("Huy", "https://github.com/tplloi/g1tool/blob/master/assets/images/player/huy.jpg?raw=true");
    addPlayer("Tịnh", "https://github.com/tplloi/g1tool/blob/master/assets/images/player/tinh.jpg?raw=true");
    addPlayer("Triển", "https://github.com/tplloi/g1tool/blob/master/assets/images/player/trien.jpg?raw=true");

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
