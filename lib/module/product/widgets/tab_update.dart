import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:freshfood_app/constant.dart';
import 'package:freshfood_app/module/product/models/product.dart';
import 'package:freshfood_app/module/providers/restapi.dart';
import 'package:freshfood_app/module/providers/walletconnect.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class TabUpdateProduct extends StatefulWidget {
  const TabUpdateProduct({Key? key}) : super(key: key);

  @override
  State<TabUpdateProduct> createState() => _TabUpdateProductState();
}

class _TabUpdateProductState extends State<TabUpdateProduct> {
  bool isSelected = false;
  bool isSubmit = false;

  final sensorTemperatureController = TextEditingController();
  final sensorHumidityController = TextEditingController();
  final sensorLightController = TextEditingController();
  final sensorSoilMoistureController = TextEditingController();
  final sensorMoreNameController = TextEditingController();
  final sensorMoreValueController = TextEditingController();

  String productIdSeclected = "";

  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    sensorTemperatureController.text = "";
    sensorHumidityController.text = "";
    sensorLightController.text = "";
    sensorSoilMoistureController.text = "";
    sensorMoreNameController.text = "";
    sensorMoreValueController.text = "";
  }

  @override
  void dispose() {
    sensorTemperatureController.dispose();
    sensorHumidityController.dispose();
    sensorLightController.dispose();
    sensorSoilMoistureController.dispose();
    sensorMoreNameController.dispose();
    sensorMoreValueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var walletProvider = Provider.of<WalletProvider>(context);
    final apiProvider = RestApiProvider('https://be.freshfood.lalo.com.vn');
    var productFuture =
        walletProvider.getProductByOwner(walletProvider.account);

    return GestureDetector(
        child: Container(
      child: Column(
        children: [
          FutureBuilder<List<dynamic>>(
            future: productFuture,
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
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
                return DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  hint: const Text("Select product"),
                  items: products
                      .map((e) => DropdownMenuItem<String>(
                            value: e.productId,
                            child: Text(
                                '${e.productId} - ${e.name} - ${e.origin}'),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      isSelected = true;
                      productIdSeclected = value!;
                    });
                  },
                );
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 360.0,
            height: 100.0,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (_image != null)
                  Positioned.fill(
                    child: Image.file(
                      _image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                Positioned(
                  child: IconButton(
                    icon: const Icon(Icons.image),
                    color: primaryColor,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Choose product image'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: [
                                  GestureDetector(
                                    child: const Text('Gallery'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      _pickImage(ImageSource.gallery);
                                    },
                                  ),
                                  const SizedBox(height: 16.0),
                                  GestureDetector(
                                    child: const Text('Camera'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      _pickImage(ImageSource.camera);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: sensorTemperatureController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              icon: Icon(Icons.thermostat_outlined),
              labelText: "Temperature",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: sensorHumidityController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              icon: Icon(Icons.water_drop),
              labelText: "Humidity",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: sensorLightController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              icon: Icon(Icons.lightbulb),
              labelText: "Light",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: sensorSoilMoistureController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              icon: Icon(Icons.water_damage),
              labelText: "Soil moisture",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("More sensors (not required)"),
          TextField(
            controller: sensorMoreNameController,
            decoration: const InputDecoration(
              icon: Icon(Icons.text_fields),
              labelText: "Name",
              hintText: "name1,name2,name3,...",
            ),
          ),
          TextField(
            controller: sensorMoreValueController,
            decoration: const InputDecoration(
              icon: Icon(Icons.numbers),
              labelText: "Value",
              hintText: "value1,value2,value3,...",
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                if (sensorTemperatureController.text == "" ||
                    sensorHumidityController.text == "" ||
                    sensorLightController.text == "" ||
                    sensorSoilMoistureController.text == "") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please fill all fields"),
                    ),
                  );
                  return;
                }

                String now =
                    DateFormat('HH:mm:ss dd/MM/yyyy').format(DateTime.now());

                var sensorMoreNameList =
                    sensorMoreNameController.text.split(",");
                var sensorMoreValueList =
                    sensorMoreValueController.text.split(",");
                var sensorMoreList = <Map<String, String>>[];
                for (var i = 0; i < sensorMoreNameList.length; i++) {
                  sensorMoreList.add({
                    "stt": "${i + 5}",
                    "name": sensorMoreNameList[i],
                    "value": sensorMoreValueList[i],
                  });
                }

                var data = {
                  "title": "#$productIdSeclected",
                  "date": now,
                  "description": "Update sensors value",
                  "table": [
                    {
                      "stt": "1",
                      "name": "temperature",
                      "value": sensorTemperatureController.text,
                    },
                    {
                      "stt": "2",
                      "name": "humidity",
                      "value": sensorHumidityController.text,
                    },
                    {
                      "stt": "3",
                      "name": "light",
                      "value": sensorLightController.text,
                    },
                    {
                      "stt": "4",
                      "name": "soil_moisture",
                      "value": sensorSoilMoistureController.text,
                    },
                    ...sensorMoreList
                  ]
                };

                print(data);

                await apiProvider
                    .post('object-stores', data)
                    .then((response) async {
                  await walletProvider
                      .addLog(int.parse(productIdSeclected), response["_id"],
                          response["hash"], "")
                      .then((result) =>
                          {walletProvider.showAlertDialog(context, result)})
                      .catchError((err) => {
                            walletProvider.showAlertDialog(
                                context, err.toString())
                          });
                }).catchError((error) {
                  // Handle any errors or exceptions here
                  print('API Error: $error');
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
