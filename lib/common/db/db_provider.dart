import 'dart:async';
import 'dart:io';

import 'package:g1tool/model/player.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/bilac.dart';

/// Created by Loitp on 05,August,2022
/// Galaxy One company,
/// Vietnam
/// +840766040293
/// freuss47@gmail.com
class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  String dbName = "g1tools.db";
  String tableNamePlayer = "Player";
  String tableNameBilac = "Bilac";

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, dbName);
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE $tableNamePlayer ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "scoreString TEXT,"
          "isSelected BIT,"
          "avatar TEXT"
          ")");
      await db.execute("CREATE TABLE $tableNameBilac ("
          "id INTEGER PRIMARY KEY,"
          "time TEXT,"
          "stringJson TEXT"
          ")");
    });
  }

  addPlayer(Player p) async {
    final db = await (database);
    if (db == null) {
      return;
    }
    //get the biggest id in the table
    var table =
        await db.rawQuery("SELECT MAX(id)+1 as id FROM $tableNamePlayer");
    int? id = table.first["id"] as int?;
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into $tableNamePlayer (id,name,avatar)"
        " VALUES (?,?,?)",
        [id, p.name, p.avatar]);
    return raw;
  }

  updatePlayer(Player p) async {
    final db = await (database);
    if (db == null) {
      return;
    }
    var res = await db.update(tableNamePlayer, p.toJson(),
        where: "id = ?", whereArgs: [p.id]);
    return res;
  }

  Future<Player?> getPlayerById(int id) async {
    final db = await (database);
    if (db == null) {
      return null;
    }
    var res = await db.query(tableNamePlayer, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Player.fromJson(res.first) : null;
  }

  Future<List<Player>> getAllPlayer() async {
    final db = await (database);
    if (db == null) {
      return List.empty();
    }
    var res = await db.query(tableNamePlayer);
    List<Player> list =
        res.isNotEmpty ? res.map((c) => Player.fromJson(c)).toList() : [];
    return list;
  }

  deletePlayerById(int? id) async {
    final db = await (database);
    if (db == null) {
      return;
    }
    return db.delete(tableNamePlayer, where: "id = ?", whereArgs: [id]);
  }

  deleteAllDb() async {
    final db = await (database);
    if (db == null) {
      return;
    }
    db.rawDelete("Delete * from $tableNamePlayer");
    db.rawDelete("Delete * from $tableNameBilac");
  }

  Future<Bilac?> getBilacByTime(String time) async {
    final db = await (database);
    if (db == null) {
      return null;
    }
    var res =
        await db.query(tableNameBilac, where: "time = ?", whereArgs: [time]);
    return res.isNotEmpty ? Bilac.fromJson(res.first) : null;
  }

  addBilac(Bilac bilac) async {
    final db = await (database);
    if (db == null) {
      return;
    }
    var table =
        await db.rawQuery("SELECT MAX(id)+1 as id FROM $tableNameBilac");
    int? id = table.first["id"] as int?;
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into $tableNameBilac (id,time,stringJson)"
        " VALUES (?,?,?)",
        [id, bilac.time, bilac.stringJson]);
    return raw;
  }
}
