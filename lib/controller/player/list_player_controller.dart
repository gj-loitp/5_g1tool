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

    await addPlayer("Lợi", "https://live.staticflickr.com/5591/29952508971_636bae2edd_w.jpg");
    await addPlayer("Toại", "https://live.staticflickr.com/5591/29952508971_636bae2edd_w.jpg");
    await addPlayer("Phúc", "https://live.staticflickr.com/5591/29952508971_636bae2edd_w.jpg");
    await addPlayer("Bảo Chu", "https://live.staticflickr.com/5591/29952508971_636bae2edd_w.jpg");
    await addPlayer("Duy", "https://live.staticflickr.com/5591/29952508971_636bae2edd_w.jpg");
    await addPlayer("Linh", "https://live.staticflickr.com/5591/29952508971_636bae2edd_w.jpg");
    await addPlayer("Ngân", "https://live.staticflickr.com/5591/29952508971_636bae2edd_w.jpg");
    await addPlayer("Chi", "https://live.staticflickr.com/5591/29952508971_636bae2edd_w.jpg");
    await addPlayer("Viên", "https://live.staticflickr.com/5591/29952508971_636bae2edd_w.jpg");
    await addPlayer("Tú", "https://live.staticflickr.com/5591/29952508971_636bae2edd_w.jpg");
    await addPlayer("Huyền", "https://live.staticflickr.com/5591/29952508971_636bae2edd_w.jpg");
    await addPlayer("Bảo Huỳnh", "https://live.staticflickr.com/5591/29952508971_636bae2edd_w.jpg");
    await addPlayer("Huy", "https://live.staticflickr.com/5591/29952508971_636bae2edd_w.jpg");
    await addPlayer("Tịnh", "https://live.staticflickr.com/5591/29952508971_636bae2edd_w.jpg");
    await addPlayer("Triển", "https://live.staticflickr.com/5591/29952508971_636bae2edd_w.jpg");

    getListPlayer();
  }
}
