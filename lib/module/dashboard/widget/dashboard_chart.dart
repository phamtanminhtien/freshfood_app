import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DashboardChart extends StatefulWidget {
  DashboardChart({super.key, required this.apiChart});

  final Map<dynamic, dynamic> apiChart;

  final Color dark = Colors.black54;
  final Color normal = Colors.cyan;
  final Color light = Colors.cyan.withOpacity(0.5);

  @override
  State<StatefulWidget> createState() => DashboardChartState();
}

class DashboardChartState extends State<DashboardChart> {
  // var apiChart = {
  //   "labels": [
  //     "Apple",
  //     "Banana",
  //     "Orange",
  //     "Lemon",
  //     "Cherry",
  //     "Strawberry",
  //     "Peach",
  //     "Pineapple",
  //     "Mango",
  //     "Watermelon",
  //   ],
  //   "data": {
  //     "process": ["12", "18", "31", "12", "18", "30", "12", "18", "30", "12"],
  //     "delivery": ["20", "20", "38", "42", "20", "40", "16", "20", "35", "60"],
  //   }
  // };

  List<String> labels = [];
  Map<String, Object> data = {};
  List<String> processData = [];
  List<String> deliveryData = [];

  @override
  void initState() {
    super.initState();
    (widget.apiChart['labels'] as List?)?.forEach((e) {
      labels.add(e.toString());
    });

    data = widget.apiChart['data'] as Map<String, Object>;
    (data['process'] as List?)?.forEach((e) {
      processData.add(e.toString());
    });
    (data['delivery'] as List?)?.forEach((e) {
      deliveryData.add(e.toString());
    });
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    String text = labels[value.toInt()];
    return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Transform.rotate(
          angle: -120,
          child: SizedBox(
              width: 100,
              child: Text(
                text,
                style: style,
                overflow: TextOverflow.ellipsis,
              )),
        ));
  }

  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    const style = TextStyle(
      fontSize: 10,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: style,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.66,
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final barsSpace = 4.0 * constraints.maxWidth / 60;
            final barsWidth = 8.0 * constraints.maxWidth / 400;
            return BarChart(
              BarChartData(
                alignment: BarChartAlignment.center,
                barTouchData: BarTouchData(
                  enabled: false,
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      getTitlesWidget: bottomTitles,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: leftTitles,
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  checkToShowHorizontalLine: (value) => value % 10 == 0,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.black.withOpacity(0.1),
                    strokeWidth: 1,
                  ),
                  drawVerticalLine: false,
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                groupsSpace: barsSpace,
                barGroups: getData(barsWidth, barsSpace),
              ),
            );
          },
        ),
      ),
    );
  }

  List<BarChartGroupData> getData(double barsWidth, double barsSpace) {
    List<BarChartGroupData> barChartGroupData = [];
    deliveryData.asMap().forEach((index, value) {
      barChartGroupData.add(
        BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: double.parse(value),
              width: barsWidth,
              rodStackItems: [
                BarChartRodStackItem(
                    0, double.parse(processData[index]), widget.dark),
                BarChartRodStackItem(double.parse(processData[index]),
                    double.parse(value), widget.normal),
              ],
              borderRadius: const BorderRadius.all(Radius.zero),
            ),
          ],
        ),
      );
    });

    return barChartGroupData;
  }
}
