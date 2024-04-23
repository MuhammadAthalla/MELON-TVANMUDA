import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ujikomtvanmuda/admin/createarticle.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});
  static const routeName = 'home';

  @override
  State<HomeAdmin> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeAdmin> {
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
              padding: const EdgeInsets.only(top: 190, left: 66),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                        child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "mau cari apa?",
                          hintStyle: GoogleFonts.poppins(
                              foreground: Paint()..shader = linear)),
                    )),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.search))
                ],
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
                      "Halo Admin 👋",
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
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, CreateArticle.routName);
                                        },
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
              onTap: () {},
              child: Container(
                height: 150,
                width: 320,
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
                            height: 103,
                            width: 103,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 17),
                      child: Container(
                        width: 180,
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
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
                              style: GoogleFonts.poppins(
                                  fontSize: 10, fontWeight: FontWeight.w500),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Row(
                                children: [
                                  OutlinedButton(
                                      onPressed: () {},
                                      style: OutlinedButton.styleFrom(
                                          shadowColor:
                                              Colors.grey.withOpacity(0.5),
                                          foregroundColor: Color(0x0ff78CC5A)),
                                      child: Text("Edit")),
                                  OutlinedButton(
                                      onPressed: () {},
                                      style: OutlinedButton.styleFrom(
                                          foregroundColor: Color(0x0ff78CC5A)),
                                      child: Text("Hapus")),
                                ],
                              ),
                            )
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
