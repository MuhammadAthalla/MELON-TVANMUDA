import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:ujikomtvanmuda/theme.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

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
                      "Halo User 👋",
                      style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      "Mau belanja apa hari ini",
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.white),
                    )
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Icon(Icons.trolley),
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
                showDialog(
                    context: context, builder: (context) => customDialog());
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
                              "stock : 100",
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

class customDialog extends StatelessWidget {
  const customDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final Shader linear = const LinearGradient(
      colors: <Color>[Color(0x0ff20B263), Color(0x0ff78CC5A)],
    ).createShader(new Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Dialog(
      child: Stack(
        children: [
          CardDialog(),
          Positioned(
              right: 0,
              top: 0,
              height: 35,
              width: 35,
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(backgroundColor: Colors.red),
                  child: Image.asset('assets/svg/cancel.svg')))
        ],
      ),
    );
  }
}

class CardDialog extends StatelessWidget {
  const CardDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Melon G-22",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Lorem Ipsum Dolorsit amet jasbfshfbshfnsdadasindaJFNAUFNU",
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0x0ff78CC5A)),
                  onPressed: () {},
                  child: Text("Masukan Keranjang",
                      style: GoogleFonts.poppins(color: Colors.white))),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0x0ff78CC5A)),
                  onPressed: () {},
                  child: Text(
                    "Belanja Sekarang",
                    style: GoogleFonts.poppins(color: Colors.white),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
