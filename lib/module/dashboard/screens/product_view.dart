import 'package:flutter/material.dart';
import 'package:freshfood_app/constant.dart';
import 'package:freshfood_app/module/dashboard/widget/product_chart.dart';
import 'package:freshfood_app/module/product/models/product.dart';
import 'package:freshfood_app/module/providers/restapi.dart';

class ProductView extends StatelessWidget {
  final Product product;
  ProductView({Key? key, required this.product}) : super(key: key);

  final apiProvider = RestApiProvider('https://be.freshfood.lalo.com.vn');

  @override
  Widget build(BuildContext context) {
    String objectID = product.log?.last[0].toString() ?? "";
    if (objectID.isEmpty ||
        objectID.contains("create") ||
        product.status == -1) {
      return Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "No data",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("Please add product to view in here")
          ],
        ),
      );
    } else if (objectID.contains("delivery") || product.status == 1) {
      return Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "#${product.productId} - ${product.name}",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const Text(
              "is been delivering",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Image.asset(
              "assets/images/farmservice.png",
              width: 200,
              height: 200,
            ),
            const Text(
              "Please view on web:",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            TextButton(
                onPressed: () => {
                      Navigator.pushNamed(context, '/webview', arguments: {
                        'url': 'https://freshfood.lalo.com.vn',
                        'title': 'Freshfood'
                      })
                    },
                child: Text("https://freshfood.lalo.com.vn",
                    style: TextStyle(fontSize: 20)))
          ],
        ),
      );
    }

    String listObjectID = "";
    product.log?.forEach((e) => {
          if (isSha256(e[0]))
            {
              listObjectID.isEmpty
                  ? listObjectID += e[0]
                  : listObjectID += "," + e[0]
            }
        });

    var productFuture = apiProvider.get('object-stores/$objectID');
    var listProductFuture = apiProvider.get('object-stores?id=$listObjectID');

    return SingleChildScrollView(
        child: Column(children: [
      Container(
          padding: const EdgeInsets.only(top: 20),
          height: 320,
          child: AspectRatio(
            aspectRatio: 1.23,
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    FutureBuilder<dynamic>(
                        future: listProductFuture,
                        builder: (context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            final data = snapshot.data;

                            var listDateChart = [];
                            var listDataChart = [];

                            data.forEach((d) => {
                                  listDateChart.add(d['date']),
                                  listDataChart.add(d['table'].sublist(0, 4))
                                });

                            // var dateChart = data['date'];
                            // var dataChart = data['table'].sublist(0,
                            //     4); // get the first 4 sensors to show in chart

                            var apiChart = {
                              "date": listDateChart,
                              "data": listDataChart
                            };

                            return Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 16, left: 6),
                                child: ProductChart(apiChart: apiChart),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          )),
      Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  product.origin,
                  style: const TextStyle(fontSize: 14, color: textColor),
                ),
              ]),
        ]),
      ),

      // Sensors:
      // - Temperature,
      // - Humidity,
      // - Light,
      // - Soil Moisture
      // For each sensor, show the icons and the value by a table

      FutureBuilder<dynamic>(
          future: productFuture,
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data;
              var date = data['date'];
              var temperature = data['table'][0]['value'];
              var humidity = data['table'][1]['value'];
              var light = data['table'][2]['value'];
              var soilMoisture = data['table'][3]['value'];

              var moreSensors = data['table'].sublist(4);

              //chart

              return Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Column(children: [
                    // Time: Day, Month, Year
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          data['date'],
                          style:
                              const TextStyle(fontSize: 14, color: textColor),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Table(
                      //border: TableBorder.all(color: Colors.black),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(1),
                      },
                      children: [
                        TableRow(children: [
                          TableCell(
                              child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.thermostat_outlined,
                                  color: Colors.red,
                                  size: 20,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Temperature",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                ),
                              ],
                            ),
                          )),
                          TableCell(
                              child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  temperature.toString(),
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ],
                            ),
                          )),
                          TableCell(
                              child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text(
                                  "°C",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ],
                            ),
                          )),
                        ]),
                        TableRow(children: [
                          TableCell(
                              child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.water_drop_outlined,
                                  color: Colors.blue,
                                  size: 20,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Humidity",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                ),
                              ],
                            ),
                          )),
                          TableCell(
                              child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  humidity.toString(),
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ],
                            ),
                          )),
                          TableCell(
                              child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text(
                                  "%",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ],
                            ),
                          )),
                        ]),
                        TableRow(children: [
                          TableCell(
                              child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.lightbulb_outline,
                                  color: Colors.orange,
                                  size: 20,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Light",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                ),
                              ],
                            ),
                          )),
                          TableCell(
                              child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  light.toString(),
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ],
                            ),
                          )),
                          TableCell(
                              child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text(
                                  "lux",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ],
                            ),
                          )),
                        ]),
                        TableRow(children: [
                          TableCell(
                              child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.waterfall_chart_rounded,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Soil Moisture",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                ),
                              ],
                            ),
                          )),
                          TableCell(
                              child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  soilMoisture.toString(),
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ],
                            ),
                          )),
                          TableCell(
                              child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text(
                                  "%",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ],
                            ),
                          )),
                        ]),
                      ],
                    ),

                    FutureBuilder(
                        future: moreSensorRows(moreSensors),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return snapshot.data as Table;
                          } else if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }),
                  ]));
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return const CircularProgressIndicator();
            }
          })
    ]));
  }
}

Future<Table> moreSensorRows(List<dynamic> moreSensors) async {
  List<TableRow> rows = [];
  for (var sensor in moreSensors) {
    var sensorName = sensor['name'];
    var sensorValue = sensor['value'];

    rows.add(TableRow(children: [
      TableCell(
          child: Container(
        padding: const EdgeInsets.all(10),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_circle_outline,
                color: Colors.grey,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                sensorName,
                style: const TextStyle(fontSize: 12, color: Colors.black),
              ),
            ],
          ),
        ),
      )),
      TableCell(
          child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              sensorValue.toString(),
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
          ],
        ),
      )),
    ]));
  }
  return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
      },
      children: rows);
}

bool isSha256(String input) {
  var sha256Regex = RegExp(r'^[0-9a-f]{24}$');
  return sha256Regex.hasMatch(input);
}
