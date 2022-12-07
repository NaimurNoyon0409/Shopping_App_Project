import 'package:flutter/cupertino.dart';
import '../db/dbHelper.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  late UserModel _userModel;
  UserModel get userModel => _userModel;

  Future<UserModel?> getUserByEmail(String email) {
    return DbHelper.getUserByEmail(email);
  }

  Future<int> insertNewUser(UserModel userModel) {
    return DbHelper.insertUser(userModel);
  }

  Future<void> getUserById(int id) async {
    _userModel = await DbHelper.getUserById(id);
  }


}

