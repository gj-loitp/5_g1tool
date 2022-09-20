import 'package:g1tool/model/player.dart';
import 'package:get/get.dart';

import '../../model/bilac.dart';

class BilacMainController extends GetxController {
  void genNewSession(List<Player> listPlayerSelected) {
    Session session = Session();
    session.time = DateTime.now().toIso8601String();
  }
}
