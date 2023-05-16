import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freshfood_app/module/home/models/field.dart';
import 'package:freshfood_app/module/home/widgets/field_card.dart';
import 'package:freshfood_app/module/home/widgets/weather_card.dart';
import 'package:freshfood_app/module/product/models/product.dart';
import 'package:freshfood_app/module/providers/restapi.dart';
import 'package:freshfood_app/module/providers/walletconnect.dart';
import 'package:provider/provider.dart';
import '../../../constant.dart';

final List<Field> fields = [
  Field(
    imageUrl:
        "https://cdn.mos.cms.futurecdn.net/sKbruCKdeZpKnNpcwf35fc-1200-80.jpg",
    name: "Field 1",
    location: "Location 1",
  ),
  Field(
    imageUrl:
        "https://cdn.mos.cms.futurecdn.net/sKbruCKdeZpKnNpcwf35fc-1200-80.jpg",
    name: "Field 2",
    location: "Location 2",
  ),
  Field(
    imageUrl:
        "https://cdn.mos.cms.futurecdn.net/sKbruCKdeZpKnNpcwf35fc-1200-80.jpg",
    name: "Field 3",
    location: "Location 3",
  ),
  Field(
    imageUrl:
        "https://cdn.mos.cms.futurecdn.net/sKbruCKdeZpKnNpcwf35fc-1200-80.jpg",
    name: "Field 4",
    location: "Location 4",
  ),
  Field(
    imageUrl:
        "https://cdn.mos.cms.futurecdn.net/sKbruCKdeZpKnNpcwf35fc-1200-80.jpg",
    name: "Field 5",
    location: "Location 5",
  ),
  Field(
    imageUrl:
        "https://cdn.mos.cms.futurecdn.net/sKbruCKdeZpKnNpcwf35fc-1200-80.jpg",
    name: "Field 6",
    location: "Location 6",
  ),
  Field(
    imageUrl:
        "https://cdn.mos.cms.futurecdn.net/sKbruCKdeZpKnNpcwf35fc-1200-80.jpg",
    name: "Field 7",
    location: "Location 7",
  ),
  Field(
    imageUrl:
        "https://cdn.mos.cms.futurecdn.net/sKbruCKdeZpKnNpcwf35fc-1200-80.jpg",
    name: "Field 8",
    location: "Location 8",
  ),
  Field(
    imageUrl:
        "https://cdn.mos.cms.futurecdn.net/sKbruCKdeZpKnNpcwf35fc-1200-80.jpg",
    name: "Field 9",
    location: "Location 9",
  ),
  Field(
    imageUrl:
        "https://cdn.mos.cms.futurecdn.net/sKbruCKdeZpKnNpcwf35fc-1200-80.jpg",
    name: "Field 10",
    location: "Location 10",
  ),
  Field(
    imageUrl:
        "https://cdn.mos.cms.futurecdn.net/sKbruCKdeZpKnNpcwf35fc-1200-80.jpg",
    name: "Field 11",
    location: "Location 11",
  ),
  Field(
    imageUrl:
        "https://cdn.mos.cms.futurecdn.net/sKbruCKdeZpKnNpcwf35fc-1200-80.jpg",
    name: "Field 12",
    location: "Location 12",
  ),
  Field(
    imageUrl:
        "https://cdn.mos.cms.futurecdn.net/sKbruCKdeZpKnNpcwf35fc-1200-80.jpg",
    name: "Field 13",
    location: "Location 13",
  ),
  Field(
    imageUrl:
        "https://cdn.mos.cms.futurecdn.net/sKbruCKdeZpKnNpcwf35fc-1200-80.jpg",
    name: "Field 14",
    location: "Location 14",
  ),
  Field(
    imageUrl:
        "https://cdn.mos.cms.futurecdn.net/sKbruCKdeZpKnNpcwf35fc-1200-80.jpg",
    name: "Field 15",
    location: "Location 15",
  ),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double bgHeight = 200;

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

  String weatherIcon = "assets/weather_icons/rain_sun.png";
  String weatherLocation = "Hanoi, Vietnam";
  String weatherTemperature = "30";
  String weatherDate = "Monday, 20 July 2020";

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).viewPadding.top;
    final walletProvider = Provider.of<WalletProvider>(context);
    var productFuture =
        walletProvider.getProductByOwner(walletProvider.account);
    // final apiProvider = RestApiProvider('https://be.freshfood.lalo.com.vn');

    // apiProvider.get('object-stores').then((response) {
    //   // Handle the response data here
    //   print(response);
    // }).catchError((error) {
    //   // Handle any errors or exceptions here
    //   print('API Error: $error');
    // });

    // create container with background i circle
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
                                children: const [
                                  Text(
                                    "Good morning",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w200,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    "Admin",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20),
                                  )
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
                          "My Fields",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                      ),
                      FutureBuilder<List<dynamic>>(
                          future: productFuture,
                          builder:
                              (context, AsyncSnapshot<List<dynamic>> snapshot) {
                            if (snapshot.hasData) {
                              final data = snapshot.data;
                              List<Product> products = [];
                              data?[0]
                                      ?.map((e) => products.add(Product(
                                            productId: e[0].toString(),
                                            name: e[1],
                                            origin: e[2],
                                          )))
                                      .toList() ??
                                  [];
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
                          })
                    ],
                  ))),
        )
      ],
    );
  }
}
