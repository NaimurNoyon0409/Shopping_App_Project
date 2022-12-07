import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/helper_function.dart';
import 'launcher_page.dart';

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
      backgroundColor: const Color(0xFFf7f2ff),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             Text(
              'Welcome',
              style: GoogleFonts.acme(color: const Color(0xFFda2079),fontSize: 46),
            ),
            const SizedBox(height: 50,),
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
                                BorderSide(color: Color(0xFFda2079), width: 1))),
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
                                BorderSide(color: Color(0xFFda2079), width: 1))),
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
                          child: Text('Login',style: GoogleFonts.acme(color: const Color(0xFFda2079),fontSize: 20),),
                        ),
                        const SizedBox(
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
                          child: Text('Register',style: GoogleFonts.acme(color: const Color(0xFFda2079),fontSize: 20),),
                        ),
                      ],
                    ),
                    const SizedBox(
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
