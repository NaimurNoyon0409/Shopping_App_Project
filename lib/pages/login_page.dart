import 'package:flutter/material.dart';
import 'package:shopping_project/pages/product_list_page.dart';

import '../models/user_model.dart';
import '../providers/user_provider.dart';
import '../utils/helper_function.dart';
import 'launcher_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String errMsg = '';
  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Login Page',
              style: TextStyle(fontSize: 26),
            ),
            Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            hintText: 'Your Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide:
                                BorderSide(color: Colors.blue, width: 1))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: true,
                        controller: passController,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide:
                                BorderSide(color: Colors.blue, width: 1))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            if(_formKey.currentState!.validate())
                            {
                              setLoginStatus(true).then((value) {
                                Navigator.pushReplacementNamed(context, LauncherPage.routeName);
                              });
                            }
                          },
                          child: Text('Login'),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        TextButton(
                          onPressed: () {
                            if(_formKey.currentState!.validate())
                            {
                              setLoginStatus(true).then((value) {
                                Navigator.pushReplacementNamed(context, LauncherPage.routeName);
                              });
                            }
                          },
                          child: Text('Register'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      errMsg,
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  _setErrorMsg(String msg) {
    setState(() {
      errMsg = msg;
    });
  }
}
