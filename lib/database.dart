import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase{
  // INITDATABASE Function :::

  Future<Database> initDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'demodatabase2.db');
    return await openDatabase(databasePath);
  }

// COPYTOROOT Function

  Future<bool> copyPasteAssetFileToRoot() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "demodatabase2.db");

    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data =
      await rootBundle.load(join('assets/database', 'demodatabase2.db'));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
      return true;
    }
    return false;
  }
  Future<List<Map<String, Object?>>> getDataFromStudent() async {
    Database db = await initDatabase();
    var data = await db.rawQuery("select * from student");
    return data;

  }
  Future<int> deleteStudent(int id) async {
    Database db = await initDatabase();
    var data =db.delete("student",where: "studentID=?",whereArgs:[id]);
    return data;
  }

}