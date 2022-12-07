import 'package:flutter/material.dart';
import 'package:shopping_project/pages/product_list_page.dart';
import '../utils/helper_function.dart';
import 'login_page.dart';


class LauncherPage extends StatefulWidget {
  static const String routeName = '/launcher';
  const LauncherPage({Key? key}) : super(key: key);

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    redirectUser();
    super.initState();
  }

  Future<void> redirectUser() async {
    if(await getLoginStatus()) {
      Navigator.pushReplacementNamed(context, ProductListPage.routeName);
    } else {
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator(),),
    );
  }
}









