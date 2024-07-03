import 'package:flutter/material.dart';
import 'package:ujikomtvanmuda/authentication/login.dart';
import 'package:ujikomtvanmuda/home/homeScreen.dart';
import 'package:ujikomtvanmuda/pages/detailscreen.dart';
import 'package:ujikomtvanmuda/pages/home.dart';

class splashScreen extends StatelessWidget {
  static String routeName = 'splashScreen';
  const splashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, LoginPage.routeName);
              },
              child: Text("login or register")),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, HomeScreen.routeName);
              },
              child: Text("home sam")),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, DetailScreen.routeName);
              },
              child: Text("detail screen")),

        ],
      ),
    );
  }
}
