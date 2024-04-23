import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:ujikomtvanmuda/authentication/login.dart';

class RegisterPage extends StatefulWidget {
  static String routeName = 'register_page';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  _RegisterPageState();

  bool showProgress = false;
  bool visible = false;

  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobile = TextEditingController();

  bool _isObscure = true;
  bool _isObscure2 = true;

  //File? file;
  var options = ['user', 'admin'];

  var _currentItemSelected = "user";
  var role = "user";

  @override
  Widget build(BuildContext context) {
    final Shader linear = const LinearGradient(
      colors: <Color>[Color(0x0ff20B263), Color(0x0ff78CC5A)],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
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
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabled: true,
                      border: const GradientOutlineInputBorder(
                          gradient: LinearGradient(
                              colors: [Color(0xFF20B263), Color(0x0ff78CC5A)]),
                          width: 2,
                          borderRadius:
                              BorderRadius.all(Radius.circular(44.0))),
                      hintText: "email",
                      hintStyle: GoogleFonts.poppins(
                          foreground: Paint()..shader = linear)),
                  validator: (value) {
                    if (value!.length == 0) {
                      return "Email cannot be empty";
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return ("Please enter a valid email");
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {},
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: _isObscure,
                  controller: passwordController,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(_isObscure
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                      filled: true,
                      enabled: true,
                      fillColor: Colors.white,
                      border: const GradientOutlineInputBorder(
                          gradient: LinearGradient(
                              colors: [Color(0xFF20B263), Color(0x0ff78CC5A)]),
                          width: 2,
                          borderRadius:
                              BorderRadius.all(Radius.circular(44.0))),
                      hintText: "Password",
                      hintStyle: GoogleFonts.poppins(
                          foreground: Paint()..shader = linear)),
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{6,}$');
                    if (value!.isEmpty) {
                      return "Password cannot be empty";
                    }
                    if (!regex.hasMatch(value)) {
                      return ("please enter valid password min. 6 character");
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {},
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: _isObscure2,
                  controller: confirmPassController,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObscure2 = !_isObscure2;
                            });
                          },
                          icon: Icon(_isObscure2
                              ? Icons.visibility_off
                              : Icons.visibility)),
                      filled: true,
                      fillColor: Colors.white,
                      enabled: true,
                      border: const GradientOutlineInputBorder(
                          gradient: LinearGradient(
                              colors: [Color(0xFF20B263), Color(0x0ff78CC5A)]),
                          width: 2,
                          borderRadius:
                              BorderRadius.all(Radius.circular(44.0))),
                      hintText: "Confirm Password",
                      hintStyle: GoogleFonts.poppins(
                          foreground: Paint()..shader = linear)),
                  validator: (value) {
                    if (confirmPassController.text != passwordController.text) {
                      return "Password did not match";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {},
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Role : ",
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          foreground: Paint()..shader = linear),
                    ),
                    DropdownButton<String>(
                      dropdownColor: Colors.white,
                      isDense: true,
                      isExpanded: false,
                      iconEnabledColor: Colors.white,
                      focusColor: Colors.white,
                      items: options.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(
                            dropDownStringItem,
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                foreground: Paint()..shader = linear),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValueSelected) {
                        setState(() {
                          _currentItemSelected = newValueSelected!;
                          role = newValueSelected;
                        });
                      },
                      value: _currentItemSelected,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 65,
                  width: 350,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 4),
                          blurRadius: 5.0)
                    ],
                    gradient: const LinearGradient(
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
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      setState(() {
                        showProgress = true;
                      });
                      signUp(
                          emailController.text, passwordController.text, role);
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      child: Text(
                        'Register',
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
                              child: const Text("you have an account?"))
                        ],
                      )),
                      Positioned(
                          child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, LoginPage.routeName);
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
      ),
    );
  }

  void signUp(String email, String password, String role) async {
    setState(() {
      showProgress = true;
    });

    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Jika pendaftaran berhasil, lanjutkan untuk menyimpan detail pengguna ke Firestore
        if (userCredential.user != null) {
          postDetailsToFirestore(email, role);
        } else {
          // Tangani kasus di mana userCredential.user null
        }
      } catch (e) {
        // Tangani kesalahan saat mencoba mendaftar
        print("Error: $e");
        setState(() {
          showProgress = false;
        });
      }
    }
  }

  postDetailsToFirestore(String email, String role) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(user!.uid).set({'email': emailController.text, 'role': role});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
