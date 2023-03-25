import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:freshfood_app/constant.dart';
import 'package:freshfood_app/module/home/screens/home.dart';
import 'package:freshfood_app/icon_navigator_bar.dart';
import 'package:freshfood_app/module/auth/screens/login.dart';

void main() {
  runApp(const MyApp());
}

const Radius navigatorBarRadius = Radius.circular(20);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fresh Food App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  const PageType(page: Home(), backgroundColor: Colors.white),
  const PageType(page: Home(), backgroundColor: Colors.white),
  const PageType(page: Home(), backgroundColor: Colors.white),
  const PageType(page: LoginScreenWidget(), backgroundColor: primaryColor),
  // const Home(),
];

class _MyHomePageState extends State<MyHomePage> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[pageIndex].page, bottomNavigationBar: bottomNavigationBar);
  }

  Widget get bottomNavigationBar {
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon_Navigator_Bar(
                icon: Icons.home_filled,
                isSelected: pageIndex == 0,
                onTap: () {
                  setState(() {
                    pageIndex = 0;
                  });
                },
              ),
              Icon_Navigator_Bar(
                icon: Icons.home_filled,
                isSelected: pageIndex == 1,
                onTap: () {
                  setState(() {
                    pageIndex = 1;
                  });
                },
              ),
              Icon_Navigator_Bar(
                icon: Icons.home_filled,
                isSelected: pageIndex == 2,
                onTap: () {
                  setState(() {
                    pageIndex = 2;
                  });
                },
              ),
              Icon_Navigator_Bar(
                icon: Icons.person_sharp,
                isSelected: pageIndex == 3,
                onTap: () {
                  setState(() {
                    pageIndex = 3;
                  });
                },
              ),
            ],
          ),
        ));
  }
}
