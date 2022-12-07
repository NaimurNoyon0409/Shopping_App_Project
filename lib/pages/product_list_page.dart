import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_project/pages/add_product_page.dart';
import 'package:shopping_project/pages/product_details_page.dart';

import '../providers/product_provider.dart';
import '../utils/helper_function.dart';
import 'launcher_page.dart';

class ProductListPage extends StatefulWidget {
  static const String routeName = '/home';
  const ProductListPage({Key? key}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  void didChangeDependencies() {
    Provider.of<ProductProvider>(context, listen: false).getAllProducts();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product List'),
        actions: [
          IconButton(
            onPressed: () {
              setLoginStatus(false).then((value) {
                Navigator.pushReplacementNamed(context, LauncherPage.routeName);
              });
            },
            icon: const Icon(Icons.logout),
          )
        ],),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, NewProductAddPage.routeName);
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.productList.length,
          itemBuilder: (context, index) {
            final product = provider.productList[index];
            return ListTile(
              onTap: ()=> Navigator.pushNamed(context,ProductDetailsPage.routeName,
              arguments: [product.id, product.name]),
              leading: Image.file(File(product.image), width: 100,height: 100,fit: BoxFit.cover, ),
              title: Text(product.name),
              subtitle: Text(product.type),
            );
          },
        ),
      ),
    );
  }
}
