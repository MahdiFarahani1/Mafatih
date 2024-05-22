import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBhelper {
  Future initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "db.sqlite");

    final exist = await databaseExists(path);

    if (exist) {
    } else {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
      ByteData data =
          await rootBundle.load(join("assets/database", "db.sqlite"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    }
    return openDatabase(path);
  }

  Future<List<Map<String, dynamic>>> getCat() async {
    Database db = await initDb();
    return db.query(
      'articlesgroups',
      where: "parent_id =0",
    );
  }

  Future<List<Map<String, dynamic>>> getArticle(int id) async {
    Database db = await initDb();

    // Query the articlesgroups table
    List<Map<String, dynamic>> articleGroups = await db.query(
      'articlesgroups',
      where: 'parent_id = ?',
      whereArgs: [id],
    );

    // Query the article table
    List<Map<String, dynamic>> articles = await db.query(
      'articles',
      where: 'groupId = ?',
      whereArgs: [id],
    );

    // Combine the results
    List<Map<String, dynamic>> combinedResults = [];
    combinedResults.addAll(articleGroups);
    combinedResults.addAll(articles);

    return combinedResults;
  }

  Future<List<Map<String, dynamic>>> getNewContent(int id) async {
    Database db = await initDb();
    return db.query('articles', where: 'groupId = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getRealArticle(int id) async {
    Database db = await initDb();
    return db.query('articles', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getSearch(String query) async {
    Database db = await initDb();
    return db.rawQuery("SELECT * FROM articles WHERE title LIKE '%$query%'");
    // return db.query('articles', where: 'title LIKE ?', whereArgs: ['%$query%']);
  }

  Future<List<Map<String, dynamic>>> getAllsave() async {
    Database db = await initDb();
    return db.query(
      'bookmark',
    );
  }

  insertArticle(
      {required String title, required int id, required int groupId}) async {
    Database db = await initDb();
    db.insert("bookmark", {
      "id": id,
      "groupId": groupId,
      "title": title,
    });
  }

  deleteArticle({
    required int id,
  }) async {
    Database db = await initDb();
    db.delete("bookmark", where: "id = ?", whereArgs: [id]);
  }
}
