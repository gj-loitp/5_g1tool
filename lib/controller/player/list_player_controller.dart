import 'package:g1tool/model/player.dart';
import 'package:get/get.dart';

import '../../common/db/db_provider.dart';

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
    bool isExist(Player player, List<Player> list) {
      var isExist = false;
      for (var p in list) {
        if (p.name == player.name && p.avatar == player.avatar) {
          isExist = true;
        }
      }
      return isExist;
    }

    Future<void> addPlayer(String name, String avatar) async {
      Player player = Player();
      player.name = name;
      player.avatar = avatar;
      player.isSelected = false;
      if (!isExist(player, listPlayer)) {
        await DBProvider.db.addPlayer(player);
      }
    }

    await addPlayer("Lợi",
        "https://github.com/tplloi/g1tool/blob/master/assets/images/player/loi.jpg?raw=true");
    await addPlayer("Toại",
        "https://github.com/tplloi/g1tool/blob/master/assets/images/player/toai.jpeg?raw=true");
    await addPlayer("Phúc",
        "https://github.com/tplloi/g1tool/blob/master/assets/images/player/phuc.jpg?raw=true");
    await addPlayer("Bảo Chu",
        "https://github.com/tplloi/g1tool/blob/master/assets/images/player/baochu.jpg?raw=true");
    await addPlayer("Duy",
        "https://github.com/tplloi/g1tool/blob/master/assets/images/player/duy.jpg?raw=true");
    await addPlayer("Linh",
        "https://github.com/tplloi/g1tool/blob/master/assets/images/player/linh.jpg?raw=true");
    await addPlayer("Ngân",
        "https://github.com/tplloi/g1tool/blob/master/assets/images/player/ngan.jpg?raw=true");
    await addPlayer("Chi",
        "https://github.com/tplloi/g1tool/blob/master/assets/images/player/chi.jpg?raw=true");
    await addPlayer("Viên",
        "https://github.com/tplloi/g1tool/blob/master/assets/images/player/vien.jpg?raw=true");
    await addPlayer("Tú",
        "https://github.com/tplloi/g1tool/blob/master/assets/images/player/tu.jpg?raw=true");
    await addPlayer("Huyền",
        "https://github.com/tplloi/g1tool/blob/master/assets/images/player/huyen.jpg?raw=true");
    await addPlayer("Bảo Huỳnh",
        "https://github.com/tplloi/g1tool/blob/master/assets/images/player/baohuynh.jpg?raw=true");
    await addPlayer("Huy",
        "https://github.com/tplloi/g1tool/blob/master/assets/images/player/huy.jpg?raw=true");
    await addPlayer("Tịnh",
        "https://github.com/tplloi/g1tool/blob/master/assets/images/player/tinh.jpg?raw=true");
    await addPlayer("Triển",
        "https://github.com/tplloi/g1tool/blob/master/assets/images/player/trien.jpg?raw=true");

    getListPlayer();
  }
}
