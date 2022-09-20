import 'package:flutter/foundation.dart';

class Player {
  String? name;
  String? avatar;
  int? id;
  bool? isWin;

  Player({
    this.name,
    this.avatar,
    this.id,
    this.isWin,
  });

  Player.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    avatar = json['avatar'];
    id = json['id'];
    isWin = json['isWin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['avatar'] = avatar;
    data['id'] = id;
    data['isWin'] = isWin;
    return data;
  }

  String getName() {
    if (kDebugMode) {
      return "$id - $name";
    } else {
      return "$name";
    }
  }
}
