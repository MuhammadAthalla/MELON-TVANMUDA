import 'package:flutter/material.dart';
import 'package:ujikomtvanmuda/authentication/login.dart';

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
        ],
      ),
    );
  }
}
