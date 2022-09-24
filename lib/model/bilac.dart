import 'dart:convert';

import 'package:g1tool/model/player.dart';

class Bilac {
  int? id;
  String? stringJson;
  String? time;

  Bilac({
    this.id,
    this.stringJson,
    this.time,
  });

  Bilac.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stringJson = json['stringJson'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['stringJson'] = stringJson;
    data['time'] = time;
    return data;
  }

  List<Player> getListPlayer() {
    var s = stringJson;
    if (s == null || s.isEmpty == true) {
      return List.empty();
    }
    return (json.decode(s) as List)
        .map((data) => Player.fromJson(data))
        .toList();
  }

  void setListPlayer(List<Player> list) {
    stringJson = jsonEncode(list);
  }
}
