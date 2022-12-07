import 'dart:io';

import 'package:flutter/material.dart';
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
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  ListTile(
                    title: Text(product.name),
                    subtitle: Text(product.type),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        Text('4.5'),
                      ],
                    ),
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
