import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_project/pages/add_product_page.dart';
import 'package:shopping_project/pages/launcher_page.dart';
import 'package:shopping_project/pages/login_page.dart';
import 'package:shopping_project/pages/product_details_page.dart';
import 'package:shopping_project/pages/product_list_page.dart';
import 'package:shopping_project/providers/product_provider.dart';
import 'package:shopping_project/providers/user_provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider())
      ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: LauncherPage.routeName,
      routes: {
        ProductListPage.routeName:(context)=> const ProductListPage(),
        NewProductAddPage.routeName:(context)=> const NewProductAddPage(),
        ProductDetailsPage.routeName:(context)=> const ProductDetailsPage(),
        LoginPage.routeName: (context) => const LoginPage(),
        LauncherPage.routeName: (context) => const LauncherPage()
      },
    );
  }
}
