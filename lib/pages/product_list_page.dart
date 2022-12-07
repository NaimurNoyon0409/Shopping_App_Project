import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_project/pages/add_product_page.dart';
import 'package:shopping_project/pages/product_details_page.dart';

import '../providers/product_provider.dart';

class ProducListPage extends StatefulWidget {
  static const String routeName = '/home';
  const ProducListPage({Key? key}) : super(key: key);

  @override
  State<ProducListPage> createState() => _ProducListPageState();
}

class _ProducListPageState extends State<ProducListPage> {
  @override
  void didChangeDependencies() {
    Provider.of<ProductProvider>(context, listen: false).getAllProducts();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, NewProductAddPage.routeName);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(title: const Text("Product List"),),
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
