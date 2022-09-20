import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
    if (index < 0 || index > listScore.length - 1) {
      return RESULT_NONE;
    } else {
      return listScore[index];
    }
  }

  void updateScoreByIndex(int index, String score) {
    var listScore = getListScore();
    print("updateScoreByIndex index $index");
    print("updateScoreByIndex score $score");
    print("updateScoreByIndex scoreString $scoreString");
    print("updateScoreByIndex listScore $listScore");
    if (index < 0 || index > listScore.length - 1) {
      //do nothing
    } else {
      listScore[index] = score;
      print("updateScoreByIndex listScore after $listScore");

      String tmpScoreString = "";
      for (int i = 0; i < listScore.length; i++) {
        var item = listScore[i];
        print(">>> $i -> $item");
        if (item.isEmpty) {
          tmpScoreString += "#${Player.RESULT_NONE}";
        } else {
          var itemPrev = listScore[i - 1];
          if (itemPrev.isEmpty) {
            tmpScoreString += item;
          } else {
            tmpScoreString += "#$item";
          }
        }
      }

      scoreString = tmpScoreString;
      print("updateScoreByIndex ~~scoreString $scoreString");
    }
  }

  int getNumberOfRound() {
    var listScore = getListScore();
    if (listScore.isEmpty) {
      return 0;
    } else {
      int num = 0;
      for (var score in listScore) {
        if (score != RESULT_NONE) {
          num++;
        }
      }
      return num;
    }
  }

  Color getColorByScore(int index, String? score) {
    if (index == 0) {
      return Colors.yellow;
    } else if (score == RESULT_NONE) {
      return Colors.white;
    } else if (score == RESULT_WIN) {
      return Colors.green;
    } else if (score == RESULT_LOSE) {
      return Colors.redAccent;
    } else {
      return Colors.yellow;
    }
  }
}
