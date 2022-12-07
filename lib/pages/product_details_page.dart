import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopping_project/providers/product_provider.dart';
import '../models/product_model.dart';
import '../utils/helper_function.dart';

class ProductDetailsPage extends StatefulWidget {
  static const String routeName = '/details';
  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
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
      appBar: AppBar(title: Text(name),
      backgroundColor: const Color(0xFFda2079),),
      body: Center(
        child: FutureBuilder<ProductModel>(
          future: provider.getProductById(id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final product = snapshot.data!;
              return ListView(
                children: [
                  Image.file(
                    File(product.image),
                    width: 200,
                    height: 250,
                    fit: BoxFit.contain,
                  ),
                  ListTile(
                    title: Text("Product Name : ${product.name}",
                      style: GoogleFonts.acme(color: const Color(0xFFda2079),fontSize: 20),),
                    subtitle: Text("Product Categories : ${product.type}",
                      style: GoogleFonts.acme(color: Colors.black38,fontSize: 15),),
                  ),
                  ListTile(
                    title: const Text('Price'),
                    trailing: Text('\$${product.price}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(product.description),
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
