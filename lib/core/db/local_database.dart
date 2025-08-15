import 'dart:io';

import 'package:flutter_review/models/emp_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {

  static Database? _db;

  Future<Database> get db async{
    if( _db != null ) {
      return _db!;
    } else {
      _db = await _initDb();
    }
    return _db!;
  }

  Future<Database> _initDb() async{
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'employees.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE employees(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        age INT,
        position TEXT,
      )
      '''
    );
  }


  Future getEmployees() async {
    final dbClient = await LocalDatabase().db;
    return await dbClient.query('employees');
  }

  Future addEmployee(EmpModel emp) async {
    final dbClient = await LocalDatabase().db;
    return await dbClient.insert('employees', emp.toMap());
  }

  // Future updateEmployee(String id) async {
  //   final db = await LocalDatabase().db;
  //   return await db.update('employees', where: 'id = ?', whereArgs: [id]);
  // }

  Future deleteEmployee(String id) async {
    final db = await LocalDatabase().db;
    return await db.delete('employees', where: 'id = ?', whereArgs: [id]);
  }

}