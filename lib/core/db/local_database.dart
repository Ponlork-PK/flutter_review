import 'dart:io';
import 'package:flutter_review/models/products_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {

  static final LocalDatabase _localDatabase = LocalDatabase._internal();
  factory LocalDatabase() => _localDatabase;
  LocalDatabase._internal();

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
    String path = join(dir.path, 'products.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE products(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        quantity INTEGER NOT NULL
      )
      '''
    );
  }


  Future<List<ProductsModel>> getProducts() async {
    final dbClient = await db;
    final res = await dbClient.query('products');
    return res.map((e) => ProductsModel.fromMap(e)).toList();
  }

  Future insertProducts(ProductsModel products) async {
    final dbClient = await db;
    return await dbClient.insert('products', products.toMap());
  }

  Future deleteProducts(int id) async {
    final dbClient = await db;
    return await dbClient.delete('products', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateProducts(ProductsModel product) async {
    final dbClient = await LocalDatabase().db;
    final data = {
      'name': product.name,
      'price': product.price,
      'quantity': product.quantity,
    };
    return await dbClient.update( 'products', data, where: 'id = ?', whereArgs: [product.id]);
  }


}