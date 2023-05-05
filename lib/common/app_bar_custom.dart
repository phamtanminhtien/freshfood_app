import 'package:flutter/material.dart';
import 'package:freshfood_app/module/auth/providers/metamask.dart';
import 'package:freshfood_app/module/auth/screens/login.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant.dart';

// rgba(74, 191, 120, 1)

class AppBarCustom extends StatelessWidget with PreferredSizeWidget {
  final bool isBack;
  final bool isLogout;

  final String nameScreen;
  final String descriptionScreen;
  final Function? onBackChanged;

  const AppBarCustom({
    Key? key,
    required this.isBack,
    required this.isLogout,
    required this.nameScreen,
    required this.descriptionScreen,
    this.onBackChanged,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Consumer<WalletProvider>(builder: (context, walletProvider, child) {
      return AppBar(
        elevation: 0,
        scrolledUnderElevation: 4,
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              style: GoogleFonts.getFont('Poppins', color: Colors.black),
              children: [
                TextSpan(
                  text: nameScreen,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const TextSpan(text: "\n"),
                TextSpan(
                    text: descriptionScreen,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      color: textColor,
                    )),
              ]),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: isBack
            ? GestureDetector(
                onTap: () {
                  onBackChanged!();
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: SvgPicture.asset(
                    'assets/icons/app_bar_back.svg',
                    width: 30,
                    fit: BoxFit.scaleDown,
                  ),
                ))
            : const SizedBox(),
        actions: [
          isLogout
              ? GestureDetector(
                  onTap: () async {
                    await walletProvider.disconnect().then((status) => {
                          if (status)
                            {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
                                  (route) => false)
                            }
                        });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: SvgPicture.asset(
                      'assets/icons/app_bar_logout.svg',
                      width: 30,
                      fit: BoxFit.scaleDown,
                    ),
                  ))
              : const SizedBox(),
        ],
      );
    });
  }
}
