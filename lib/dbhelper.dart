import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:interview/main.dart';
import 'package:interview/models/usermodel.dart';
import 'package:interview/screens/dashboardscreen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBase {
  Future<Database> initializedDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'user_database.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE user(id INTEGER PRIMARY KEY, firstname TEXT, lastname TEXT, username TEXT, email TEXT, password TEXT, confirmationpassword TEXT)",
        );
      },
    );
  }

  Future insertDog(Users users) async {
    final Database db = await initializedDB();

    await db
        .insert(
      'user',
      users.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    )
        .whenComplete(() {
      return true;
    });
  }

  Future<List<Users>> retrievePlanets() async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult = await db.query(
      'user',
    );
    return queryResult.map((e) {
      var user = Users.fromMap(e);
      print(user);
      return user;
    }).toList();
  }

  Future<Users> loginuser(
      {required String username,
      required String password,
      required BuildContext context}) async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
      'SELECT * FROM user WHERE (email=?  OR username= ?) AND password = ?',
      ['$username', username, password],
      // where: 'email = ?  username = ?',
      // whereArgs: [username, username],
    );
    if (queryResult.isEmpty) {
      Fluttertoast.showToast(msg: "No User Found");
    } else
      print(queryResult);
    return queryResult
        .map((e) {
          var user = Users.fromMap(e);
          storage.write("name", user.firstname + " " + user.lastname);
          Navigator.of(context).push(
              MaterialPageRoute(builder: ((context) => DashboardScreen())));
          return user;
        })
        .toList()
        .first;
  }
}
