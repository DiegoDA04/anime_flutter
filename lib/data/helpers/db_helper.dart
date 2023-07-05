import 'package:anime_flutter/data/models/anime.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DbHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE animes(
      id INTEGER KEY NOT NULL,
      title TEXT,
      image_url TEXT,
      year INTEGER,
      is_favorite INTEGER
    )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('animedb', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<void> insertAnime(Anime anime) async {
    final db = await DbHelper.db();
    await db.insert('animes', anime.toMap(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Anime>> fetchAnimes() async {
    final db = await DbHelper.db();

    final data = await db.query('animes', orderBy: "id");

    return data.map((e) => Anime.fromDbMap(e)).toList();
  }

  static Future<void> deleteAnime(Anime anime) async {
    final db = await DbHelper.db();
    try {
      await db.delete('animes', where: "id = ?", whereArgs: [anime.id]);
    } catch (err) {
      debugPrint("Algo paso mano u.u: $err");
    }
  }
}
