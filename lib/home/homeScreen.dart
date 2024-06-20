import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ujikomtvanmuda/home/cart.dart';
import 'package:ujikomtvanmuda/home/dashboard.dart';
import 'package:ujikomtvanmuda/home/profile.dart';
import 'package:ujikomtvanmuda/pages/detailscreen.dart';
import 'package:ujikomtvanmuda/pages/home.dart';
import 'package:ujikomtvanmuda/theme.dart';

List<IconData> navIcon = [Icons.home, Icons.carpenter, Icons.people];

List<String> navTitle = ["Home", "Cart", "Profile"];

List<Widget> screens = [DashBoardPage(), CartPage(), ProfilePage()];

int selectedIndex = 0;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Shader linear = const LinearGradient(
      colors: <Color>[Color(0x0ff20B263), Color(0x0ff78CC5A)],
    ).createShader(new Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: const TabBarView(
          children: [
            Center(
              child: Home(),
            ),
            Center(
              child: CartPage(),
            ),
            Center(
              child: ProfilePage(),
            ),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.home),
              text: "Home",
            ),
            Tab(
              icon: Icon(Icons.trolley),
              text: "Cart",
            ),
            Tab(
              icon: Icon(Icons.person),
              text: "profile",
            )
          ],
        ),
      ),
    );
  }
}
