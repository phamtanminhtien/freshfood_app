import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constant.dart';

// rgba(74, 191, 120, 1)

class IconNavigatorBar extends StatelessWidget {
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;

  const IconNavigatorBar({
    Key? key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromRGBO(217, 217, 217, .4)
              : Colors.white,
          borderRadius: BorderRadius.circular(10),
          // boxShadow: [
          //   if (isSelected)
          //     const BoxShadow(
          //       color: Color.fromRGBO(217, 217, 217, 0.5),
          //       spreadRadius: 5,
          //       blurRadius: 7,
          //       offset: Offset(0, 3), // changes position of shadow
          //     ),
          // ],
        ),
        child: SvgPicture.asset(
          icon,
          width: 10,
          fit: BoxFit.scaleDown,
          // size: 35,
          color: isSelected
              ? primaryColor
              : const Color.fromRGBO(148, 148, 148, 1),
        ),
      ),
    );
  }
}
