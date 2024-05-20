import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:ujikomtvanmuda/theme.dart';

class ForgotPassssword extends StatefulWidget {
  const ForgotPassssword({super.key});

  @override
  State<ForgotPassssword> createState() => _ForgotPasssswordState();
}

class _ForgotPasssswordState extends State<ForgotPassssword> {
  final _authService = FirebaseAuth.instance;
  final _email = TextEditingController();
  final Shader linear = const LinearGradient(
    colors: <Color>[Color(0x0ff20B263), Color(0x0ff78CC5A)],
  ).createShader(new Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Masukkan email untuk mereset password",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _email,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  enabled: true,
                  border: const GradientOutlineInputBorder(
                      gradient: LinearGradient(
                          colors: [Color(0xFF20B263), Color(0x0ff78CC5A)]),
                      width: 2,
                      borderRadius: BorderRadius.all(Radius.circular(44.0))),
                  hintText: "Masukkan Email",
                  hintStyle:
                      GoogleFonts.poppins(foreground: Paint()..shader = linear),
                  label: Text(
                    "Email",
                    style: GoogleFonts.poppins(
                        foreground: Paint()..shader = linear),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                      colors: [Color(0xff20B263), Color(0xff78CC5A)])),
              child: TextButton(
                  onPressed: () async {
                    await sendResetPasswordLink(_email.text);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "Email untuk mereset password sudah terkirim ke email")));
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Kirim Email",
                    style: GoogleFonts.poppins(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Future<void> sendResetPasswordLink(String email) async {
    try {
      await _authService.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }
}
