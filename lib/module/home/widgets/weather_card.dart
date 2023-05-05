import 'package:flutter/material.dart';
import 'package:freshfood_app/constant.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({
    Key? key,
    required this.icon,
    required this.location,
    required this.date,
    required this.temperature,
  }) : super(key: key);

  final String icon;
  final String location;
  final String date;
  final String temperature;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Image.asset(
          icon,
          width: 150,
          height: 150,
          fit: BoxFit.cover,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  location,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 15),
                )),
            Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  date,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w200,
                      fontSize: 13),
                )),
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  '$temperature°C',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 40),
                )),
          ],
        ),
      ]),
    );
  }
}
