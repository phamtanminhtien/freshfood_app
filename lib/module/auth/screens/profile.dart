import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freshfood_app/common/app_bar_custom.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:freshfood_app/constant.dart';
import 'package:freshfood_app/module/providers/walletconnect.dart';
import 'package:web3dart/web3dart.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    var walletProvider = Provider.of<WalletProvider>(context);

    final companyName = TextEditingController();
    final companyDescription = TextEditingController();

    String myAccount = walletProvider.getFullAccountStr(false);
    Future<double> balanceFuture = walletProvider.getBalance();
    Future<List<dynamic>> ownerFuture =
        walletProvider.getOwnerByAddress(walletProvider.account);

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
                        FutureBuilder<double>(
                          future: balanceFuture,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final balance = snapshot.data;
                              return Text('${balance!.toStringAsFixed(5)}');
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
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
                          "No Data",
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
                        ? TextField(
                            decoration: InputDecoration(
                              hintText: companyName.text,
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                            ),
                            controller: companyName,
                          )
                        : FutureBuilder<List<dynamic>>(
                            future: ownerFuture,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final name = snapshot.data;
                                return Text("${name![0][0]}",
                                    style: GoogleFonts.getFont('Poppins',
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400));
                              } else {
                                return const Text("");
                              }
                            },
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
                        ? TextField(
                            decoration: InputDecoration(
                              hintText: companyDescription.text,
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                            ),
                            controller: companyDescription,
                          )
                        : FutureBuilder<List<dynamic>>(
                            future: ownerFuture,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final name = snapshot.data;
                                return Text("${name![0][1]}",
                                    style: GoogleFonts.getFont('Poppins',
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400));
                              } else {
                                return const Text("");
                              }
                            },
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
                onPressed: () async {
                  if (isEdit) {
                    print("Save");
                    await walletProvider
                        .registerOwner(
                            companyName.text, companyDescription.text)
                        .then((result) =>
                            {walletProvider.showAlertDialog(context, result)})
                        .catchError((err) => {
                              walletProvider.showAlertDialog(
                                  context, err.toString())
                            });
                  }
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
  }
}
