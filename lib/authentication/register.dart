import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:ujikomtvanmuda/authentication/login.dart';

class RegisterPage extends StatelessWidget {
  static String routeName = 'register_page';

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
              Text("Keep Connected",
                  style: GoogleFonts.poppins(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()..shader = linear)),
              Text("Create your new account",
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()..shader = linear)),
              SizedBox(
                height: 30,
              ),
              TextField(
                decoration: InputDecoration(
                    border: GradientOutlineInputBorder(
                        gradient: LinearGradient(
                            colors: [Color(0xFF20B263), Color(0x0ff78CC5A)]),
                        width: 2,
                        borderRadius:
                            BorderRadius.all(const Radius.circular(44.0))),
                    hintText: "Username",
                    hintStyle: GoogleFonts.poppins(
                        foreground: Paint()..shader = linear)),
              ),
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
                    hintText: "email",
                    hintStyle: GoogleFonts.poppins(
                        foreground: Paint()..shader = linear)),
              ),
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
                    hintText: "Password",
                    hintStyle: GoogleFonts.poppins(
                        foreground: Paint()..shader = linear)),
              ),
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
                    hintText: "Confirm Password",
                    hintStyle: GoogleFonts.poppins(
                        foreground: Paint()..shader = linear)),
              ),
              SizedBox(
                height: 10,
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
              Stack(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Positioned(
                        child: Row(
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: Text("you have an account?"))
                      ],
                    )),
                    Positioned(
                        child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, LoginPage.routeName);
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  foreground: Paint()..shader = linear),
                            )))
                  ],
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
