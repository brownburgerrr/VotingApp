import 'package:flutter/material.dart';
import 'loginscreen.dart';
import 'resultscreen.dart';
import 'homescreen.dart';
import 'signupscreen.dart';
import 'firstscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'minorproject01-29ca6',
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/loginscreen': (context) => loginscreen(),
        '/signupscreen': (context) => signupscreen(),
        '/homescreen': (context) => homescreen(),
        '/resultscreen': (context) => resultscreen(),
      },
      home: firstscreen(),
    );

  }
}