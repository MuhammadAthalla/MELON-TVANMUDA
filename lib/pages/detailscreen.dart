import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:ujikomtvanmuda/theme.dart';


class DetailScreen extends StatelessWidget {
  static String routeName = 'detail_screen';
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double paddingTop = MediaQuery.of(context).padding.top;
    double paddingBottom = MediaQuery.of(context).padding.bottom;
    return Scaffold(
        appBar: AppBar(
          title: Text("TITLE"),
          centerTitle: true,
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text("Melon G-2",
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  )),
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
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 200),
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Text(
                              "Melon memiliki banyak khasiat untuk tubuh. Dilansir dari laman Kemenkes RI (TKPI) ada beberapa manfaat yang dimiliki melon, yaitu melancarkan sistem peredaran tubuh, membantu kinerja saraf dan otak, baik untuk sistem reproduksi, hingga sistem integumen.Di bawah ini terdapat 5 cara menanam melon yang bisa kamu terapkan.Menyiapkan Biji Melon Cara pertama yang dapat dilakukan adalah menyiapkan biji melon. Sisihkan biji melon dari buahnya dan rendam dengan air hangat selama ± 2 jam.Sebaiknya kamu menggunakan air matang atau air kemasan untuk merendam. Kemudian, pilihlah biji yang tenggelam. Biji-biji tersebut adalah biji yang memiliki kualitas baik dan layak tanam.Setelah diambil, jangan lupa untuk mengeringkan biji terlebih dahulu sebelum disemai.Germinasi Biji Melon Cara menggerminasi biji melon sangat mudah. Kamu hanya perlu menyiapkan wadah berupa baskom dan kapas.Sebelum kapas diletakkan ke wadah, basahi terlebih dahulu dengan air kemasan. Tujuannya adalah agar media lembab dan tidak kering.Selanjutnya, letakkan beberapa biji di atas kapas. Pastikan ada jarak antar biji agar pertumbuhan bibit nanti lancar.Setelahnya, tutup wadah dengan kain dan letakkan di tempat yang teduh. Kamu perlu memeriksa pertumbuhannya setiap hari.Biji melon umumnya akan menumbuhkan tunas dan berkecambah dalam waktu 3-9 hari. Apabila tinggi kecambah mencapai 1-3 cm, kamu bisa mulai menyemainya.Menyemai Bibit MelonSebelum menyemai, siapkan terlebih dahulu wadah, bisa berupa pot atau polybag. Berikan media berupa tanah, padi sekam, dan pupuk organik dengan takaran yang sama.Media yang dimasukkan dalam wadah cukup sampai ¾ saja. Selanjutnya, masukkan bibit melon yang telah berkecambah ke dalam media semai. Siram dengan air secara perlahan-lahan, kamu hanya perlu membasahinya agar lembab.Pastikan setiap hari media tanam tidak kering. Kamu bisa menyiramnya hanya saat kering saja. Bibit tersebut dapat ditanam setelah memiliki 2-6 helai.Menanam Bibit MelonCara selanjutnya adalah menanam bibit melon. Bibit yang telah memiliki minimal 2-6 helai, bisa dipindahkan ke media tanam. Media tanam bisa menggunakan polybag atau pot dengan ukuran sedang hingga besar. Pastikan juga wadah memiliki lubang untuk mengalirkan air. Media tanam sama dengan media semai dengan takaran tanah lebih banyak dibandingkan yang lain, yaitu dalam rasio 2:1:1. Lubangi tanah untuk menanam bibit, kemudian pindahkan bibit ke lubang tersebut. Setelah proses tanam selesai, pindahkan ke tempat teduh namun cukup untuk mendapatkan akses sinar matahari. Setelah tumbuh daun baru, wadah bisa dipindahkan ke tempat terbukaPerawatan TanamanPerawatan pertama adalah penyiraman. Apabila media tanam kering, siram sebanyak 2x1 hari. Namun, jika tanah sudah lembab, kamu cukup menyiramnya sebanyak 1 kali saja. Jangan lupa untuk rutin memberikan pupuk organik. Kemudian tambahkan penyangga ketika tanaman sudah tumbuh sepanjang 15-15 cm. Penyulaman juga bisa dilakukan saat tanaman tumbuh kurang baik. Kamu juga perlu rutin memeriksanya dan pastikan melon terhindar dari gulma dan hama. Buah melon siap kamu panen saat berusia 2-3 bulan setelah ditanam. Itulah dia beberapa cara menanam melon dari biji. Mudah, bukan? [ENF] ")),
                    ),
                  ),
                  Container(
                    height: 200,
                    width: 1000,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        )),
                  ),
                ],
              ),
              Container(child: FieldComment(context)),
            ]),
          ),
        )));
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
                      Colors.black.withAlpha(30)
                    ]),
                    width: 2,
                    borderRadius:
                        BorderRadius.all(const Radius.circular(44.0))),
                hintText: "Tambahkan Komentar",
                hintStyle: GoogleFonts.poppins(),
              ),
            )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.send_rounded,
                  color: primary,
                )),
          ],
        ));
  }
}
