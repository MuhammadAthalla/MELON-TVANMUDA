import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ujikomtvanmuda/admin/homeadmin.dart';
import 'package:ujikomtvanmuda/admin/shop/shopadmin.dart';

List<IconData> navIcon = [Icons.home, Icons.carpenter];

List<String> navTitle = [
  "Home",
  "Cart",
];

List<Widget> screens = [HomeAdmin(), ShopAdmin()];

int selectedIndex = 0;

class AdminPage extends StatefulWidget {
  static String routeName = 'admin_page';
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    final Shader linear = const LinearGradient(
      colors: <Color>[Color(0x0ff20B263), Color(0x0ff78CC5A)],
    ).createShader(new Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: const TabBarView(
          children: [
            Center(
              child: HomeAdmin(),
            ),
            Center(
              child: ShopAdmin(),
            ),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.home),
              text: "Chats",
            ),
            Tab(
              icon: Icon(Icons.trolley),
              text: "Cart",
            ),
          ],
        ),
      ),
    );
  }
}
