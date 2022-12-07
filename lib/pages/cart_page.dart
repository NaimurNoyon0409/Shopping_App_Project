import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopping_project/pages/product_details_page.dart';
import 'package:shopping_project/providers/product_provider.dart';
import '../models/product_model.dart';

class CartPage extends StatefulWidget {
  static const String routeName = '/cart';
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late int id;
  late String name;
  late ProductProvider provider;

  void didChangeDependencies() {
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    provider = Provider.of<ProductProvider>(context, listen: false);
    id = argList[0];
    name = argList[1];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf7f2ff),
      appBar: AppBar(title: const Text("My Cart"),
        backgroundColor: const Color(0xFFda2079),),
      body: Center(
        child: FutureBuilder<ProductModel>(
          future: provider.getProductById(id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final product = snapshot.data!;
              return ListView(
                children: [
                  ListTile(
                    leading: Image.file(File(product.image), width: 100, height: 100, fit: BoxFit.contain,),
                    title: Text(product.name,
                        style: GoogleFonts.acme(color: const Color(0xFFda2079),fontSize: 20)),
                    subtitle: Text('\$${product.price}',
                      style: GoogleFonts.abel(color: Colors.black,fontSize: 15),),
                    trailing: const Icon(Icons.delete,size: 25,color:Color(0xFFda2079) ,),
                  ),
                ],
              );
            }

            if (snapshot.hasError) {
              return const Text('Failed to load data');
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
