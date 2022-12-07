import 'package:flutter/cupertino.dart';

import '../db/dbHelper.dart';
import '../models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> productList = [];

  Future<int> insertProduct(ProductModel productModel) =>
      DbHelper.insertProduct(productModel);

  void getAllProducts() async {
    productList = await DbHelper.getAllProducts();
    notifyListeners();
  }

}