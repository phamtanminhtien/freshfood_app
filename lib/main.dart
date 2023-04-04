import 'package:flutter/material.dart';
import 'package:freshfood_app/constant.dart';
import 'package:freshfood_app/module/auth/screens/login.dart';
import 'package:freshfood_app/module/auth/screens/profile.dart';
import 'package:freshfood_app/module/home/screens/home.dart';
import 'package:freshfood_app/module/product/screens/product.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

const Radius navigatorBarRadius = Radius.circular(20);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fresh Food App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: GoogleFonts.getFont('Poppins').fontFamily,
      ),
      home: const MyHomePage(title: 'Fresh Food App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginScreen(),
    );
  }
}
