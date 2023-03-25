import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WalletButton {
  const WalletButton({
    required this.icon,
    required this.onTap,
  });

  final String icon;
  final VoidCallback onTap;

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: // Generated code for this Container Widget...
          Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
          child: SvgPicture.asset(
            icon,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
