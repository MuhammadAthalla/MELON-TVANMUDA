import 'package:flutter/material.dart';
import 'package:ujikomtvanmuda/admin/createarticle.dart';
import 'package:ujikomtvanmuda/admin/homeadmin.dart';
import 'package:ujikomtvanmuda/admin/tabcontroller.dart';
import 'package:ujikomtvanmuda/authentication/login.dart';
import 'package:ujikomtvanmuda/authentication/register.dart';
import 'package:ujikomtvanmuda/home/homeScreen.dart';
import 'package:ujikomtvanmuda/pages/detailscreen.dart';
import 'package:ujikomtvanmuda/pages/home.dart';
import 'package:ujikomtvanmuda/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: home(),
      theme: ThemeData(),
      initialRoute: splashScreen.routeName,
      routes: {
        splashScreen.routeName: (context) => splashScreen(),
        LoginPage.routeName: (context) => LoginPage(),
        RegisterPage.routeName: (context) => RegisterPage(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        DetailScreen.routeName: (context) => DetailScreen(),
        home.routeName: (context) => home(),
        HomeAdmin.routeName: (context) => HomeAdmin(),
        AdminPage.routeName:(context) => AdminPage(),
        CreateArticle.routName:(context) => CreateArticle()
      },
    );
  }
}
