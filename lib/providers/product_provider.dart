import 'package:flutter/cupertino.dart';

import '../db/dbHelper.dart';
import '../models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> movieList = [];

  Future<int> insertMovie(ProductModel productModel) =>
      DbHelper.insertProduct(productModel);

}