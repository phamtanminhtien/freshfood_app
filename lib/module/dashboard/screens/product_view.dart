import 'package:flutter/material.dart';
import 'package:freshfood_app/common/app_bar_custom.dart';
import 'package:freshfood_app/module/dashboard/widget/product_chart.dart';
import 'package:freshfood_app/module/dashboard/widget/dashboard_chart.dart';
import 'package:freshfood_app/constant.dart';
import 'package:freshfood_app/module/providers/restapi.dart';
import 'package:freshfood_app/module/utils/hash-object.dart';
import 'package:provider/single_child_widget.dart';
import 'package:freshfood_app/module/product/models/product.dart';

import '../widget/product_card.dart';

class ProductView extends StatelessWidget {
  final Product product;
  ProductView({Key? key, required this.product}) : super(key: key);

  final apiProvider = RestApiProvider('https://be.freshfood.lalo.com.vn');

  @override
  Widget build(BuildContext context) {
    print("product view::::" + product.name);

    var objectData = {};
    String objectID = product.log?[0].toString() ?? "";
    String objectHash = product.log?[1].toString() ?? "";
    if (objectID.isEmpty || objectID.contains("create")) {
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
    }
    var productFuture = apiProvider.get('object-stores/$objectID');

    return SingleChildScrollView(
        child: Column(children: [
      Container(
          padding: EdgeInsets.only(top: 20),
          height: 300,
          child: AspectRatio(
            aspectRatio: 1.23,
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16, left: 6),
                        child: ProductChart(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          )),
      Container(
        padding: EdgeInsets.only(left: 20, right: 20),
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
