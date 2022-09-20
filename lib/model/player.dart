import 'package:flutter/foundation.dart';

const int RESULT_NONE = -1;
const int RESULT_WIN = 1;
const int RESULT_LOSE = 0;

class Player {
  String? name;
  String? avatar;
  int? id;
  int? result;
  bool? isSelected;

  Player({
    this.name,
    this.avatar,
    this.id,
  });

  Player.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    avatar = json['avatar'];
    id = json['id'];
    result = json['result'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['avatar'] = avatar;
    data['id'] = id;
    data['result'] = result;
    data['isSelected'] = isSelected;
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
