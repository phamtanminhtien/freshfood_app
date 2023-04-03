import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:freshfood_app/constant.dart';
import 'package:freshfood_app/common/icon_navigator_bar.dart';
import 'package:freshfood_app/module/home/screens/home.dart';
import 'package:freshfood_app/module/auth/screens/profile.dart';
import 'package:freshfood_app/module/auth/screens/login.dart';
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

class PageType {
  final Widget page;
  final Color backgroundColor;

  const PageType({required this.page, required this.backgroundColor});
}

final List<PageType> pages = [
  const PageType(page: Home(), backgroundColor: homeBackgroundColor),
  const PageType(page: ProductScreen(), backgroundColor: homeBackgroundColor),
  const PageType(page: LoginScreen(), backgroundColor: primaryColor),
  const PageType(page: ProfileScreen(), backgroundColor: homeBackgroundColor),
];

class _MyHomePageState extends State<MyHomePage> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _buildBody(), bottomNavigationBar: _bottomNavigationBar);
  }

  Widget _buildBody() {
    return Container(alignment: Alignment.center, child: pages[pageIndex].page);
  }

  Widget get _bottomNavigationBar {
    return Container(
        color: pages[pageIndex].backgroundColor,
        child: Container(
            height: 80,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: navigatorBarRadius,
                topRight: navigatorBarRadius,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconNavigatorBar(
                    icon: "assets/icons/bottom_nav_home.svg",
                    isSelected: pageIndex == 0,
                    onTap: () {
                      setState(() {
                        pageIndex = 0;
                      });
                    },
                  ),
                  IconNavigatorBar(
                    icon: "assets/icons/bottom_nav_plus.svg",
                    isSelected: pageIndex == 1,
                    onTap: () {
                      setState(() {
                        pageIndex = 1;
                      });
                    },
                  ),
                  IconNavigatorBar(
                    icon: "assets/icons/bottom_nav_chart.svg",
                    isSelected: pageIndex == 2,
                    onTap: () {
                      setState(() {
                        pageIndex = 2;
                      });
                    },
                  ),
                  IconNavigatorBar(
                    icon: "assets/icons/bottom_nav_user.svg",
                    isSelected: pageIndex == 3,
                    onTap: () {
                      setState(() {
                        pageIndex = 3;
                      });
                    },
                  ),
                ],
              ),
            )));
  }
}
