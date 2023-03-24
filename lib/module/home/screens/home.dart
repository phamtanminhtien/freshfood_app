import 'package:flutter/material.dart';

Color green = const Color.fromRGBO(74, 191, 120, 1);

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // create container with background i circle
    return Stack(children: <Widget>[
      Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: green,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.only(top: 50, left: 40, right: 40),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: const [
                    Text(
                      'Good Morning',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w100),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      )
    ]);
  }
}
