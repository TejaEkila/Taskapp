// ignore_for_file: avoid_print

import 'package:path/path.dart';
import 'package:someapp/model/model.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  Future<Database> initDB() async {
    // create database
    String path = await getDatabasesPath();
    //print('Database path: $path');

    return openDatabase(
      join(
        //set database path
        path,
        //set database Name
        "gotask.db",
      ),
      onCreate: (database, version) async {
        //create database table and variable
        await database.execute("""
   CREATE TABLE GOTASK(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    taskname TEXT NOT NULL,
    setdate TEXT NOT NULL,
    description TEXT NOT NULL,
    isImportant INTEGER NOT NULL,
    isNone INTEGER NOT NULL
  )
""");
      },

      //version name
      version: 4,
    );
  }

  //Inserting the data into the data table
 Future<bool> insertDB(DataModel dataModel) async {
  try {
    final Database db = await initDB();
    print('Database initialized successfully'); // Add this line
    await db.insert("GOTASK", dataModel.toMap());
    print('Data inserted successfully'); // Add this line
    return true;
  } catch (e) {
    print('Error inserting data: $e');
    return false;
  }
}

  Future<List<DataModel>> getData() async {
    try {
      final Database db = await initDB();
      //get the data from database using query object
      final List<Map<String, Object?>> datas = await db.query("GOTASK");
      return datas.map((e) => DataModel.fromMap(e)).toList();
    } catch (e) {
      print('Error getting data: $e');
      return [];
    }
  }

  Future<void> updateData(DataModel dataModel, int id) async {
    try {
      print(id);
      final Database db = await initDB();
      // update the data into database using id locations
      await db.update("GOTASK", dataModel.toMap(), where: "id=?", whereArgs: [id]).then((value) => print("success"));
    } catch (e) {
      print('Error updating data: $e');
    }
  }

  Future<void> deleteData(int id) async {
    try {
      final Database db = await initDB();
      //delete the data using id
      await db.delete("GOTASK", where: "id=?", whereArgs: [id]);
    } catch (e) {
      print('Error deleting data: $e');
    }
  }
}
