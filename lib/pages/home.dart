import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ujikomtvanmuda/home/cart.dart';
import 'package:ujikomtvanmuda/home/dashboard.dart';
import 'package:ujikomtvanmuda/home/profile.dart';
import 'package:ujikomtvanmuda/pages/detailscreen.dart';
import 'package:ujikomtvanmuda/theme.dart';

List<IconData> navIcon = [Icons.home, Icons.carpenter, Icons.people];

List<String> navTitle = ["Home", "Cart", "Profile"];

List<Widget> screens = [DashBoardPage(), CartPage(), ProfilePage()];

int selectedIndex = 0;

class Home extends StatefulWidget {
  const Home({super.key});
  static const routeName = 'home';

  @override
  State<Home> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final Shader linear = const LinearGradient(
      colors: <Color>[Color(0x0ff20B263), Color(0x0ff78CC5A)],
    ).createShader(new Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: height / 2.5,
            decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(100)),
                gradient: LinearGradient(
                    colors: [Color(0xFF20B263), Color(0x0ff78CC5A)])),
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(top: 185, left: 66),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2.0,
                          blurRadius: 32.0,
                          offset: const Offset(4.0, 4.0))
                    ]),
                width: width / 1.5,
                height: height / 6,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 90, left: 20),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Halo User 👋",
                      style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      "Mau belajar apa hari ini",
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.white),
                    )
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 60,
                            width: 138,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2.0,
                                    blurRadius: 32.0,
                                    offset: const Offset(4.0, 4.0))
                              ],
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Row(
                              // Use a Row for horizontal layout
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween, // Align icons
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Tambah\nData",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        foreground: Paint()..shader = linear),
                                  ),
                                ),
                                ShaderMask(
                                    blendMode: BlendMode.srcIn,
                                    shaderCallback: (Rect bounds) =>
                                        const RadialGradient(
                                            center: Alignment.topCenter,
                                            stops: [
                                              .5,
                                              1
                                            ],
                                            colors: [
                                              Color(0xFF20B263),
                                              Color(0x0ff78CC5A)
                                            ]).createShader(bounds),
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.add,
                                          size: 35,
                                        )))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 370, left: 44),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, DetailScreen.routeName);
              },
              child: Container(
                height: 134,
                width: 321,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2.0,
                          blurRadius: 32.0,
                          offset: const Offset(4.0, 4.0))
                    ],
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(17),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            height: 100,
                            width: 100,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 17, bottom: 17),
                      child: Container(
                        width: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Melon G-2",
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  foreground: Paint()..shader = linear),
                            ),
                            Text(
                              "Melon memiliki banyak khasiat untuk tubuh. Dilansir dari laman Kemenkes RI (TKPI) ada beberapa manfaat yang dimiliki melon, yaitu melancarkan sistem peredaran tubuh, membantu kinerja saraf dan otak, baik untuk sistem reproduksi, hingga sistem integumen.Di bawah ini terdapat 5 cara menanam melon yang bisa kamu terapkan.Menyiapkan Biji Melon Cara pertama yang dapat dilakukan adalah menyiapkan biji melon. Sisihkan biji melon dari buahnya dan rendam dengan air hangat selama ± 2 jam.Sebaiknya kamu ",
                              style: GoogleFonts.poppins(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
