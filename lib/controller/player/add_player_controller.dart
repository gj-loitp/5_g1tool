import 'package:g1tool/model/player.dart';
import 'package:get/get.dart';

import '../../common/db/db_provider.dart';

class AddPlayerController extends GetxController {
  var name = "".obs;

  void setName(String s) {
    name.value = s;
  }

  bool isValidName() {
    return name.value.isNotEmpty;
  }

  Future<int> addPlayer(String name) async {
    Player p = Player();
    p.name = name;
    p.avatar =
        "https://live.staticflickr.com/575/33169799475_17f36bcb58_q.jpg";
    return await DBProvider.db.addClient(p);
  }
}
