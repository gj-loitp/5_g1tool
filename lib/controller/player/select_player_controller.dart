import 'package:g1tool/model/player.dart';
import 'package:get/get.dart';

import '../../common/db/db_provider.dart';

class SelectPlayerController extends GetxController {
  var listPlayer = <Player>[].obs;

  void getListPlayer() async {
    var list = await DBProvider.db.getAllPlayer();
    listPlayer.clear();
    listPlayer.addAll(list);
    listPlayer.refresh();
  }

  bool isEmptyData() {
    return listPlayer.isEmpty;
  }

  bool isEmptyListPlayerSelected() {
    return getListPlayerSelected().isEmpty;
  }

  List<Player> getListPlayerSelected() {
    return listPlayer.where((p) => p.isSelected == true).toList();
  }

  void toggleSelectPlayer(int index) {
    if (listPlayer[index].isSelected == null ||
        listPlayer[index].isSelected == false) {
      listPlayer[index].isSelected = true;
    } else {
      listPlayer[index].isSelected = false;
    }
    listPlayer.refresh();
  }
}
