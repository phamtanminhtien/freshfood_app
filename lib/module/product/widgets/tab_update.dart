import 'package:flutter/material.dart';
import 'package:freshfood_app/constant.dart';
import 'package:freshfood_app/module/product/widgets/input_element.dart';
import 'package:freshfood_app/module/product/models/product.dart';
import 'package:web3dart/web3dart.dart';

final List<Product> products = [
  Product(
      productId: "1",
      name: "Apple",
      origin: "Viet Nam",
      image: "assets/images/field.png",
      location: null,
      sensors: {
        "temperature": 30,
        "humidity": 50,
        "soil_moisture": 60,
      }),
  Product(
      productId: "2",
      name: "Banana",
      origin: "Viet Nam",
      image: "assets/images/field.png",
      location: null,
      sensors: {
        "temperature": 31,
        "humidity": 51,
        "soil_moisture": 61,
      }),
  Product(
      productId: "3",
      name: "Orange",
      origin: "Viet Nam",
      image: "assets/images/field.png",
      location: null,
      sensors: {
        "temperature": 32,
        "humidity": 52,
        "soil_moisture": 62,
      }),
];

class TabUpdateProduct extends StatefulWidget {
  const TabUpdateProduct({Key? key}) : super(key: key);

  @override
  State<TabUpdateProduct> createState() => _TabUpdateProductState();
}

class _TabUpdateProductState extends State<TabUpdateProduct> {
  bool isSelected = false;
  bool isSubmit = false;
  Map<String, dynamic> sensors = {
    "temperature": 100,
    "humidity": 100,
    "soil_moisture": 100,
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
      child: Column(
        children: [
          DropdownButtonFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
            hint: const Text("Select category"),
            items: products
                .map((e) => DropdownMenuItem(
                      child:
                          Text(e.productId + ' - ' + e.name + ' - ' + e.origin),
                      value: e.productId,
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                isSelected = true;
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              icon: Icon(Icons.thermostat_outlined),
              labelText: "Temperature",
            ),
            onChanged: (value) {
              setState(() {
                sensors["temperature"] = value;
                isSubmit = true;
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              icon: Icon(Icons.water),
              labelText: "Humidity",
            ),
            onChanged: (value) {
              setState(() {
                sensors["humidity"] = value;
                isSubmit = true;
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              icon: Icon(Icons.water_damage),
              labelText: "Soil moisture",
            ),
            onChanged: (value) {
              setState(() {
                sensors["soil_moisture"] = value;
                isSubmit = true;
              });
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  isSubmit = true;
                });
              },
              child: const Text("Save"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          )
        ],
      ),
    ));
  }
}
