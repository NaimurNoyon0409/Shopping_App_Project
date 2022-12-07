import 'package:sqflite/sqflite.dart';
import '../models/product_model.dart';
import 'package:path/path.dart' as Path;

import '../models/user_model.dart';

class DbHelper {
  static const String createTableProduct = '''create table $tableProduct(
  $tblProductColId integer primary key autoincrement,
  $tblProductColName text,
  $tblProductColDes text,
  $tblProductColType text,
  $tblProductColImage text,
  $tblProductColExpireDate text,
  $tblProductColPrice integer)''';

  static const String createTableUser = '''create table $tableUser(
  $tblUserColId integer primary key autoincrement,
  $tblUserColEmail text,
  $tblUserColPassword text,
  $tblUserColAdmin integer)''';


  static Future<Database> open() async {
    final rootPath = await getDatabasesPath();
    final dbPath = Path.join(rootPath, 'product_db');

    return openDatabase(dbPath, version: 1, onCreate: (db, version) async {
      await db.execute(createTableProduct);
      await db.execute(createTableUser);


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

  static Future<ProductModel> getProductById(int id) async {
    final db = await open();
    final mapList = await db.query(tableProduct, where: '$tblProductColId = ?', whereArgs: [id]);
    return ProductModel.fromMap(mapList.first);
  }

  static Future<UserModel?> getUserByEmail(String email) async {
    final db = await open();
    final mapList = await db.query(tableUser, where: '$tblUserColEmail = ?', whereArgs: [email]);
    if(mapList.isEmpty) return null;
    return UserModel.fromMap(mapList.first);
  }

  static Future<int> insertUser(UserModel userModel) async {
    final db = await open();
    return db.insert(tableUser, userModel.toMap());
  }

  static Future<UserModel> getUserById(int id) async {
    final db = await open();
    final mapList = await db.query(tableUser,
      where: '$tblUserColId = ?', whereArgs: [id],);
    return UserModel.fromMap(mapList.first);
  }


}