import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBhelper {
  Future initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "db.sqlite");

    final exist = await databaseExists(path);

    if (exist) {
      print("database alrady exists");
    } else {
      print("creating a new database");

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
      ByteData data =
          await rootBundle.load(join("assets/database", "db.sqlite"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
      print("db copy");
    }
    await openDatabase(path);
  }
}
