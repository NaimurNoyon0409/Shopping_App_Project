import 'package:flutter/material.dart';
import 'package:shopping_project/pages/add_product_page.dart';

class ProducListPage extends StatefulWidget {
  static const String routeName = '/home';
  const ProducListPage({Key? key}) : super(key: key);

  @override
  State<ProducListPage> createState() => _ProducListPageState();
}

class _ProducListPageState extends State<ProducListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, NewProductAddPage.routeName);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
