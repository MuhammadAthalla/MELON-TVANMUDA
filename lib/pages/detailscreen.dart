import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:ujikomtvanmuda/theme.dart';

class DetailScreen extends StatelessWidget {
  static String routeName = 'detail_screen';
  final String title; // Tambahkan properti judul
  final String detail; // Tambahkan properti detail

  const DetailScreen({Key? key, required this.title, required this.detail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Shader linear = const LinearGradient(
      colors: <Color>[Color(0x0ff20B263), Color(0x0ff78CC5A)],
    ).createShader(new Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
    double paddingTop = MediaQuery.of(context).padding.top;
    double paddingBottom = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Artikel",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 24,
              foreground: Paint()..shader = linear),
        ), // Gunakan judul dari properti
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()..shader = linear),
                ),
                SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2.0,
                            blurRadius: 32.0,
                            offset: const Offset(4.0, 4.0),
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 200, left: 20, right: 20, bottom: 20),
                        child: HtmlWidget(
                          detail,
                        ),
                      ),
                    ),
                    Container(
                      height: 200,
                      width: 1000,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(child: FieldComment(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget FieldComment(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double paddingTop = MediaQuery.of(context).padding.top;
    return Container(
      margin: EdgeInsets.only(top: 200),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: GradientOutlineInputBorder(
                  gradient: LinearGradient(colors: [
                    Colors.black.withAlpha(30),
                    Colors.black.withAlpha(30),
                  ]),
                  width: 2,
                  borderRadius: BorderRadius.all(const Radius.circular(44.0)),
                ),
                hintText: "Tambahkan Komentar",
                hintStyle: GoogleFonts.poppins(),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.send_rounded,
              color: primary,
            ),
          ),
        ],
      ),
    );
  }
}
