import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:freshfood_app/constant.dart';
import 'package:freshfood_app/module/auth/widgets/wallet_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  String metamaskIcon = 'assets/images/metamask.svg';
  String walletConnectIcon = 'assets/images/walletconnect.svg';
  String farmServiceIcon = 'assets/images/farmservice.png';

  WalletButton metamaskButton = WalletButton(
    icon: 'assets/images/metamask.svg',
    onTap: () {
      print('Metamask button tapped');
    },
  );

  WalletButton walletConnectButton = WalletButton(
    icon: 'assets/images/walletconnect.svg',
    onTap: () {
      print('WalletConnect button tapped');
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: primaryColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: const BoxDecoration(
              color: primaryColor,
            ),
            child: Stack(
              alignment: AlignmentDirectional.center,
              // mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Positioned(
                      //<-- SEE HERE
                      right: -80,
                      top: -80,
                      child: Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(200),
                        ),
                      ),
                    ),
                    Positioned(
                      //<-- SEE HERE
                      right: -60,
                      top: -60,
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(200),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  //<-- SEE HERE
                  left: -150,
                  bottom: -200,
                  child: Container(
                    width: 400,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(200),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.center,
                  //<-- SEE HER
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 50),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          farmServiceIcon,
                          width: 300,
                          height: 250,
                          fit: BoxFit.fitWidth,
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 50),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              decoration: const BoxDecoration(
                                color: Color(0x00FFFFFF),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text('Connect your Wallet',
                                      style: GoogleFonts.getFont(
                                        'Poppins',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                      )),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 20),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        metamaskButton.build(context),
                                        walletConnectButton.build(context),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
