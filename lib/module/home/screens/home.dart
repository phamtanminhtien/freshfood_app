import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freshfood_app/module/home/models/field.dart';
import 'package:freshfood_app/module/home/widgets/field_card.dart';
import 'package:freshfood_app/module/home/widgets/weather_card.dart';
import 'package:freshfood_app/module/product/models/product.dart';
import 'package:freshfood_app/module/providers/restapi.dart';
import 'package:freshfood_app/module/providers/walletconnect.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import 'dart:convert';

import '../../../constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double bgHeight = 200;

  double longitute = 106.7721875831758;
  double latitude = 10.850957748446847;

  String weatherIcon = "assets/weather_icons/rain_sun.png";
  String weatherLocation = "Ho Chi Minh City";
  String weatherTemperature = "30";
  String weatherDate = "Monday, 20 July 2020";

  void calculateHeight(double position) {
    if (position < 1) {
      setState(() {
        bgHeight = bgHeightDefault;
      });
    } else if (position > 0 && position < bgHeightDefault * 2) {
      setState(() {
        bgHeight = bgHeightDefault + position / 2;
      });
    } else {
      setState(() {
        bgHeight = 0;
      });
    }
  }

  bool _onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      calculateHeight(notification.metrics.pixels);
    }
    return true;
  }

  String convertTimeNowToDateTime() {
    var date = DateTime.now();
    var formattedDate = DateFormat('EEEE, d MMMM yyyy').format(date);
    return formattedDate.toString();
  }

  String getWeatherIcon(String weatherCondition) {
    switch (weatherCondition) {
      case "Clear":
        return "assets/weather_icons/sun.png";
      case "Clouds":
        return "assets/weather_icons/cloud.png";
      case "Rain":
        return "assets/weather_icons/rain.png";
      case "Snow":
        return "assets/weather_icons/snow.png";
      case "Thunderstorm":
        return "assets/weather_icons/storm.png";
      default:
        return "assets/weather_icons/sun.png";
    }
  }

  Future<void> fetchLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        latitude = position.latitude;
        longitute = position.longitude;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<Map<String, dynamic>> fetchWeatherData(
      String apiKey, double latitude, double longitude) async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        weatherLocation = json.decode(response.body)['name'];
        weatherTemperature =
            (json.decode(response.body)['main']['temp'] - 273.15)
                .toStringAsFixed(0);
        weatherDate = convertTimeNowToDateTime();
        weatherIcon =
            getWeatherIcon(json.decode(response.body)['weather'][0]['main']);
      });
      print(json.decode(response.body));
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  @override
  void initState() {
    super.initState();
    // fetchLocation();
    fetchWeatherData(dotenv.get("OPENWEATHER_API_KEY"), latitude, longitute);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).viewPadding.top;
    final walletProvider = Provider.of<WalletProvider>(context);
    var productFuture =
        walletProvider.getProductByOwner(walletProvider.account);
    var ownerFuture = walletProvider.getOwnerByAddress(walletProvider.account);

    return Stack(
      children: [
        Container(
          height: bgHeight,
          decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
        NotificationListener(
          onNotification: _onNotification,
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                  padding: EdgeInsets.only(
                      top: height,
                      left: paddingHorizontal,
                      right: paddingHorizontal),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          bottom: 20,
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Good morning",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w200,
                                        fontSize: 20),
                                  ),
                                  // Text(
                                  //   "Admin",
                                  //   style: TextStyle(
                                  //       color: Colors.white,
                                  //       fontWeight: FontWeight.w500,
                                  //       fontSize: 20),
                                  // )
                                  FutureBuilder<List<dynamic>>(
                                      future: ownerFuture,
                                      builder: (context,
                                          AsyncSnapshot<List<dynamic>>
                                              snapshot) {
                                        if (snapshot.hasData) {
                                          final data = snapshot.data;
                                          print(data);
                                          return Text(
                                            "${data![0][0]}",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20),
                                          );
                                        } else {
                                          return const Text("Admin",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20));
                                        }
                                      }),
                                ],
                              ),
                              Image.asset(
                                "assets/images/walletconnect.png",
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ]),
                      ),
                      Container(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: WeatherCard(
                              icon: weatherIcon,
                              location: weatherLocation,
                              date: weatherDate,
                              temperature: weatherTemperature)),
                      const Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Text(
                          "My Products",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: FutureBuilder<List<dynamic>>(
                            future: productFuture,
                            builder: (context,
                                AsyncSnapshot<List<dynamic>> snapshot) {
                              if (snapshot.hasData) {
                                final data = snapshot.data;
                                List<Product> products = [];
                                data?[0]
                                        ?.map((e) => products.add(Product(
                                              productId: e[0].toString(),
                                              name: e[1],
                                              origin: e[2],
                                              image: e[6],
                                            )))
                                        .toList() ??
                                    [];

                                if (products.isEmpty) {
                                  return Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: const [
                                        Text(
                                          "No data",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            "Please add product to view in here")
                                      ],
                                    ),
                                  );
                                }
                                return Column(
                                  children: products
                                      .map((e) => FieldCard(
                                            product: e,
                                          ))
                                      .toList(),
                                );
                              } else if (snapshot.hasError) {
                                return Text("Error: ${snapshot.error}");
                              } else {
                                return const CircularProgressIndicator();
                              }
                            }),
                      )
                    ],
                  ))),
        )
      ],
    );
  }
}
