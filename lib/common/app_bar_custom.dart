import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constant.dart';

// rgba(74, 191, 120, 1)

class AppBarCustom extends StatelessWidget with PreferredSizeWidget {
  final bool isBack;
  final bool isLogout;

  final String nameScreen;
  final String descriptionScreen;

  const AppBarCustom({
    Key? key,
    required this.isBack,
    required this.isLogout,
    required this.nameScreen,
    required this.descriptionScreen,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(
            text: nameScreen,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const TextSpan(text: "\n"),
          TextSpan(
              text: descriptionScreen,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: textColor,
              )),
        ]),
      ),
      centerTitle: true,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      leading: isBack
          ? GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(10.0),
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
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    'assets/icons/app_bar_logout.svg',
                    width: 30,
                    fit: BoxFit.scaleDown,
                  ),
                ))
            : const SizedBox(),
      ],
    );
  }
}
