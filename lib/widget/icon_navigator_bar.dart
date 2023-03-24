import 'package:flutter/material.dart';

// rgba(74, 191, 120, 1)

Color green = const Color.fromRGBO(74, 191, 120, 1);

class Icon_Navigator_Bar extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const Icon_Navigator_Bar({
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
          boxShadow: [
            if (isSelected)
              const BoxShadow(
                color: Color.fromRGBO(217, 217, 217, 0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
          ],
        ),
        child: Icon(
          icon,
          size: 35,
          color: isSelected ? green : const Color.fromRGBO(148, 148, 148, 1),
        ),
      ),
    );
  }
}
