import 'package:finalprojectgdsc/home_page.dart';
import 'package:finalprojectgdsc/login_page.dart';
import 'package:finalprojectgdsc/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';





void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xff070706),
      ),
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage()
      }
  
    );
  }
}


