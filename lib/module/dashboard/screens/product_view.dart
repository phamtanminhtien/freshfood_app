import 'package:flutter/material.dart';
import 'package:freshfood_app/common/app_bar_custom.dart';
import 'package:freshfood_app/module/dashboard/widget/product_chart.dart';
import 'package:freshfood_app/module/dashboard/widget/dashboard_chart.dart';
import 'package:freshfood_app/constant.dart';
import 'package:provider/single_child_widget.dart';
import 'package:freshfood_app/module/product/models/product.dart';

import '../widget/product_card.dart';

class ProductView extends StatelessWidget {
  final Product product;
  const ProductView({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(children: [
            // Time: Day, Month, Year
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Day, Month, Year",
                  style: const TextStyle(fontSize: 14, color: textColor),
                ),
              ],
            ),

            const SizedBox(
              height: 10,
            ),

            // Sensors:
            // - Temperature,
            // - Humidity,
            // - Light,
            // - Soil Moisture
            // For each sensor, show the icons and the value by a table

            Table(
              //border: TableBorder.all(color: Colors.black),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
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
                          size: 30,
                        ),
                        Text(
                          "Temperature",
                          style: TextStyle(fontSize: 12, color: Colors.black),
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
                          "20",
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
                      children: [
                        Text(
                          "°C",
                          style: const TextStyle(
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
                          size: 30,
                        ),
                        Text(
                          "Humidity",
                          style: TextStyle(fontSize: 12, color: Colors.black),
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
                          "20",
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
                      children: [
                        Text(
                          "%",
                          style: const TextStyle(
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
                          size: 30,
                        ),
                        Text(
                          "Light",
                          style: TextStyle(fontSize: 12, color: Colors.black),
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
                          "20",
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
                      children: [
                        Text(
                          "lux",
                          style: const TextStyle(
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
                          size: 30,
                        ),
                        Text(
                          "Soil Moisture",
                          style: TextStyle(fontSize: 12, color: Colors.black),
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
                          "20",
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
                      children: [
                        Text(
                          "%",
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  )),
                ]),
              ],
            ),
          ]))
    ]));
  }
}
