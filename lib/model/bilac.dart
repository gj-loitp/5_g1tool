import 'package:g1tool/model/player.dart';

class Bilac {
  List<Session>? session;

  Bilac({
    this.session,
  });

  Bilac.fromJson(Map<String, dynamic> json) {
    if (json['session'] != null) {
      session = <Session>[];
      json['session'].forEach((v) {
        session!.add(Session.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (session != null) {
      data['session'] = session!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Session {
  String? time;
  List<Game>? game;

  Session({
    this.time,
    this.game,
  });

  Session.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    if (json['game'] != null) {
      game = <Game>[];
      json['game'].forEach((v) {
        game!.add(Game.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    if (game != null) {
      data['game'] = game!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Game {
  List<Player>? listPlayer;
  List<Round>? listRound;

  Game({this.listPlayer, this.listRound});

  Game.fromJson(Map<String, dynamic> json) {
    if (json['listPlayer'] != null) {
      listPlayer = <Player>[];
      json['listPlayer'].forEach((v) {
        listPlayer!.add(Player.fromJson(v));
      });
    }
    if (json['listRound'] != null) {
      listRound = <Round>[];
      json['listRound'].forEach((v) {
        listRound!.add(Round.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (listPlayer != null) {
      data['listPlayer'] = listPlayer!.map((v) => v.toJson()).toList();
    }
    if (listRound != null) {
      data['listRound'] = listRound!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Round {
  List<Player>? team1;
  List<Player>? team2;

  Round({
    this.team1,
    this.team2,
  });

  Round.fromJson(Map<String, dynamic> json) {
    if (json['team1'] != null) {
      team1 = <Player>[];
      json['team1'].forEach((v) {
        team1!.add(Player.fromJson(v));
      });
    }
    if (json['team2'] != null) {
      team2 = <Player>[];
      json['team2'].forEach((v) {
        team2!.add(Player.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (team1 != null) {
      data['team1'] = team1!.map((v) => v.toJson()).toList();
    }
    if (team2 != null) {
      data['team2'] = team2!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
