import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:ujikomtvanmuda/authentication/register.dart';

class LoginPage extends StatelessWidget {
  static String routeName = 'login_page';

  @override
  Widget build(BuildContext context) {
    final Shader linear = LinearGradient(
      colors: <Color>[Color(0x0ff20B263), Color(0x0ff78CC5A)],
    ).createShader(new Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    return Scaffold(
        body: Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Hello Again",
                style: GoogleFonts.poppins(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()..shader = linear)),
            Text("Please sign in to your account",
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()..shader = linear)),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                  border: GradientOutlineInputBorder(
                      gradient: LinearGradient(
                          colors: [Color(0xFF20B263), Color(0x0ff78CC5A)]),
                      width: 2,
                      borderRadius:
                          BorderRadius.all(const Radius.circular(44.0))),
                  hintText: "Email",
                  hintStyle: GoogleFonts.poppins(
                      foreground: Paint()..shader = linear)),
            ),
            SizedBox(
              height: 22,
            ),
            TextField(
              decoration: InputDecoration(
                  border: GradientOutlineInputBorder(
                      gradient: LinearGradient(
                          colors: [Color(0xFF20B263), Color(0x0ff78CC5A)]),
                      width: 2,
                      borderRadius:
                          BorderRadius.all(const Radius.circular(44.0))),
                  hintText: "Password",
                  hintStyle: GoogleFonts.poppins()),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 65,
              width: 350,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 4),
                      blurRadius: 5.0)
                ],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  colors: [
                    Color(0x0ff20B263),
                    Color(0x0ff78CC5A),
                  ],
                ),
                color: Colors.deepPurple.shade300,
                borderRadius: BorderRadius.circular(44),
              ),
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                  // elevation: MaterialStateProperty.all(3),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      // fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Or Login With",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            SizedBox(
              height: 1,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/svg/google_icon.svg')),
              IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/svg/facebook_icon.svg')),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Dont Have An Account?",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterPage.routeName);
                    },
                    child: Text(
                      'Register',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          foreground: Paint()..shader = linear),
                    ))
              ],
            )
          ],
        ),
      ),
    ));
  }
}
