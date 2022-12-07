import 'dart:io';

import 'package:sqflite/sqflite.dart';

import '../models/product_model.dart';
import 'package:path/path.dart' as Path;

class DbHelper {
  static const String createTableProduct = '''create table $tableProduct(
  $tblProductColId integer primary key autoincrement,
  $tblProductColName text,
  $tblProductColDes text,
  $tblProductColType text,
  $tblProductColImage text,
  $tblProductColExpireDate text,
  $tblProductColPrice integer)''';

  static Future<Database> open() async {
    final rootPath = await getDatabasesPath();
    final dbPath = Path.join(rootPath, 'product_db');

    return openDatabase(dbPath, version: 1, onCreate: (db, version) async {
      await db.execute(createTableProduct);
    });
  }


  static Future<int> insertProduct(ProductModel productModel) async {
    final db = await open();
    return db.insert(tableProduct, productModel.toMap());
  }

  static Future<List<ProductModel>> getAllProducts() async {
    final db = await open();
    final mapList = await db.query(tableProduct);
    return List.generate(mapList.length, (index) =>
        ProductModel.fromMap(mapList[index]));
  }
}