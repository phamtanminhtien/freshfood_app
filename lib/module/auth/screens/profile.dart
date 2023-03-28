import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freshfood_app/common/app_bar_custom.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:freshfood_app/constant.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(
          isBack: true,
          isLogout: true,
          nameScreen: "Profile",
          descriptionScreen: "views the profile"),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            "Profile",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Name: ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Email: ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Phone: ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Address: ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Wallet: ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Balance: ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Role: ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Status: ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
