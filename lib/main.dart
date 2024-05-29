import 'package:flutter/material.dart';
import 'package:ujikomtvanmuda/admin/createarticle.dart';
import 'package:ujikomtvanmuda/admin/homeadmin.dart';
import 'package:ujikomtvanmuda/admin/tabcontroller.dart';
import 'package:ujikomtvanmuda/authentication/login.dart';
import 'package:ujikomtvanmuda/authentication/register.dart';
import 'package:ujikomtvanmuda/home/homeScreen.dart';
import 'package:ujikomtvanmuda/pages/createPage.dart';
import 'package:ujikomtvanmuda/pages/detailscreen.dart';
import 'package:ujikomtvanmuda/pages/editPage.dart';
import 'package:ujikomtvanmuda/pages/home.dart';
import 'package:ujikomtvanmuda/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(const Duration(seconds: 5));
  FlutterNativeSplash.remove();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Home(),
      theme: ThemeData(),
      initialRoute: LoginPage.routeName,
      routes: {
        splashScreen.routeName: (context) => splashScreen(),
        LoginPage.routeName: (context) => LoginPage(),
        RegisterPage.routeName: (context) => RegisterPage(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        DetailScreen.routeName: (context) => DetailScreen(
              title: 'title',
              detail: 'detail',
            ),
        Home.routeName: (context) => Home(),
        HomeAdmin.routeName: (context) => HomeAdmin(),
        AdminPage.routeName: (context) => AdminPage(),
        CreateArticle.routName: (context) => CreateArticle(),
        CreatePage.routeName: (context) => CreatePage(),
        EditPage.routeName: (context) => const EditPage(
              articleId: '',
              initialTitle: '',
              initialDetail: '',
            )
      },
    );
  }
}
