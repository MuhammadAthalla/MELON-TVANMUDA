import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("cart"),
      ),
      body: Center(
        child: Text(
          "CART",
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
