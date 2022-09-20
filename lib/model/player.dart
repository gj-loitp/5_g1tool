import 'package:flutter/foundation.dart';

class Player {
  static const String RESULT_NONE = "";
  static const String RESULT_WIN = "1";
  static const String RESULT_LOSE = "0";

  String? name;
  String? avatar;
  String? scoreString;
  int? id;
  bool? isSelected;

  Player({
    this.name,
    this.avatar,
    this.id,
  });

  Player.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    avatar = json['avatar'];
    scoreString = json['scoreString'];
    id = json['id'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['avatar'] = avatar;
    data['scoreString'] = scoreString;
    data['id'] = id;
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

  List<String> getListScore() {
    return scoreString?.split("#") ?? List.empty();
  }

  String? getScoreByIndex(int index) {
    var listScore = getListScore();
    if (index < 0 || index > listScore.length) {
      return RESULT_NONE;
    } else {
      return listScore[index];
    }
  }
}
