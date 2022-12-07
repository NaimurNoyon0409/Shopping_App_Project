import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      backgroundColor: const Color(0xFFf7f2ff),
      appBar: AppBar(backgroundColor:const Color(0xFFda2079),
        title: const Text('Product List'),
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
        backgroundColor: const Color(0xFFda2079),
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
            return Column(
              children: [
                InkWell(
                  onTap: () => Navigator.pushNamed(context, ProductDetailsPage.routeName,
                      arguments: [product.id, product.name]),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Image.file(
                            File(product.image),
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    product.name,
                                    style: GoogleFonts.acme(color: const Color(0xFFda2079),fontSize: 20),
                                  ),
                                  Text(
                                      '\$${product.price}',
                                    style: GoogleFonts.abel(color: Colors.black,fontSize: 15),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 80,),
                              const Icon(Icons.shopping_cart,color: Color(0xFFda2079),)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],

            );
          },
        ),
      ),
    );
  }
}
