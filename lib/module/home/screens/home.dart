import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constant.dart';

const double paddingHorizontal = 20;

class Field {
  String imageUrl;
  String name;
  String location;

  Field({
    required this.imageUrl,
    required this.name,
    required this.location,
  });
}

final List<Field> fields = [
  Field(
    imageUrl: "assets/images/field.png",
    name: "Field 1",
    location: "Location 1",
  ),
  Field(
    imageUrl: "assets/images/field.png",
    name: "Field 2",
    location: "Location 2",
  ),
  Field(
    imageUrl: "assets/images/field.png",
    name: "Field 3",
    location: "Location 3",
  ),
  Field(
    imageUrl: "assets/images/field.png",
    name: "Field 4",
    location: "Location 4",
  ),
  Field(
    imageUrl: "assets/images/field.png",
    name: "Field 5",
    location: "Location 5",
  ),
  Field(
    imageUrl: "assets/images/field.png",
    name: "Field 6",
    location: "Location 6",
  ),
  Field(
    imageUrl: "assets/images/field.png",
    name: "Field 7",
    location: "Location 7",
  ),
  Field(
    imageUrl: "assets/images/field.png",
    name: "Field 8",
    location: "Location 8",
  ),
  Field(
    imageUrl: "assets/images/field.png",
    name: "Field 9",
    location: "Location 9",
  ),
  Field(
    imageUrl: "assets/images/field.png",
    name: "Field 10",
    location: "Location 10",
  ),
  Field(
    imageUrl: "assets/images/field.png",
    name: "Field 11",
    location: "Location 11",
  ),
  Field(
    imageUrl: "assets/images/field.png",
    name: "Field 12",
    location: "Location 12",
  ),
  Field(
    imageUrl: "assets/images/field.png",
    name: "Field 13",
    location: "Location 13",
  ),
  Field(
    imageUrl: "assets/images/field.png",
    name: "Field 14",
    location: "Location 14",
  ),
  Field(
    imageUrl: "assets/images/field.png",
    name: "Field 15",
    location: "Location 15",
  ),
];

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).viewPadding.top;

    // create container with background i circle
    return Stack(
      children: [
        Container(
          height: 200,
          decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
        Expanded(
            child: Container(
                padding: EdgeInsets.only(
                    top: height,
                    left: paddingHorizontal,
                    right: paddingHorizontal),
                height: double.infinity,
                width: double.infinity,
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
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  "assets/images/sun.png",
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      "Ho Chi Minh City",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      "Friday - Mar 24",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w200,
                                          fontSize: 13),
                                    ),
                                    Text(
                                      "25°C",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 40),
                                    )
                                  ],
                                ),
                              ]),
                        )),
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
                    Expanded(
                      child: ListView.builder(
                          itemCount: fields.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 20),
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
                              child: Row(
                                children: [
                                  Image.asset(
                                    fields[index].imageUrl,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            fields[index].name,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            fields[index].location,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                    size: 20,
                                  )
                                ],
                              ),
                            );
                          }),
                    )
                  ],
                )))
      ],
    );
  }
}
