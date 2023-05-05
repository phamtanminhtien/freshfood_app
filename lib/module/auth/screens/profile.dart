import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freshfood_app/common/app_bar_custom.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:freshfood_app/constant.dart';
import 'package:freshfood_app/module/auth/providers/metamask.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<WalletProvider>(builder: (context, walletProvider, child) {
      // String myAccount = walletProvider.getAccount(0);
      // var balanceBigInt = walletProvider.getBalance(walletProvider.account);
      // String balance = balanceBigInt.toString();
      String myAccount = "0x123456789abcdef";
      String balance = "100";

      return Scaffold(
          appBar: const AppBarCustom(
              isBack: false,
              isLogout: true,
              nameScreen: "Profile",
              descriptionScreen: "views the profile"),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: paddingHorizontal),
            child: Column(children: [
              Container(
                  padding: const EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        backgroundColor: primaryColor,
                        radius: 80,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/metamask.svg',
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 20),
                          Text(
                            myAccount,
                            style: GoogleFonts.getFont('Poppins',
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      )
                    ],
                  )),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SvgPicture.asset('assets/icons/wallet.svg',
                          width: 30, height: 30, fit: BoxFit.scaleDown),
                      Column(
                        children: [
                          Text(
                            balance,
                            style: GoogleFonts.getFont('Poppins',
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "ETH",
                            style: GoogleFonts.getFont('Poppins',
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "1000",
                            style: GoogleFonts.getFont('Poppins',
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "VND",
                            style: GoogleFonts.getFont('Poppins',
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ]),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/metamask.svg',
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Company",
                          style: GoogleFonts.getFont('Poppins',
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: isEdit
                          ? const TextField(
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                                border: InputBorder.none,
                              ),
                            )
                          : Text(
                              "Company name",
                              style: GoogleFonts.getFont('Poppins',
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/walletconnect.svg',
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Description",
                          style: GoogleFonts.getFont('Poppins',
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: isEdit
                          ? const TextField(
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                                border: InputBorder.none,
                              ),
                            )
                          : Text(
                              "Company name",
                              style: GoogleFonts.getFont('Poppins',
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              Container(
                alignment: !isEdit ? Alignment.topLeft : Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      isEdit = !isEdit;
                    });
                  },
                  child: !isEdit
                      ? Text(
                          "Edit profile",
                          style: GoogleFonts.getFont('Poppins',
                              color: Colors.black,
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400),
                        )
                      : Text(
                          "Save",
                          style: GoogleFonts.getFont('Poppins',
                              color: Colors.green,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                ),
              ),
            ]),
          ));
    });
  }
}
