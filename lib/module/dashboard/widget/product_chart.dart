import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ProductChart extends StatefulWidget {
  const ProductChart({super.key, required this.apiChart});

  final Map<dynamic, dynamic> apiChart;

  @override
  State<StatefulWidget> createState() => DashboardChartState();
}

class DashboardChartState extends State<ProductChart> {
  List<String> labels = [];
  @override
  void initState() {
    super.initState();
    (widget.apiChart['date'] as List?)?.forEach((e) {
      labels.add(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.apiChart['data'][0][2]["value"]);
    return LineChart(
      sampleData,
    );
  }

  LineChartData get sampleData => LineChartData(
        lineTouchData: lineTouchData,
        gridData: gridData,
        titlesData: titlesData,
        borderData: borderData,
        lineBarsData: lineBarsData,
        // minX: 0,
        // maxX: 10,
        maxY: 100,
        minY: 0,
      );

  LineTouchData get lineTouchData => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData => [
        lineChartBarTemperature,
        lineChartBarDataHumidity,
        lineChartBarDataLight,
        lineChartBarDataSoilMoisture,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 20:
        text = '20';
        break;
      case 40:
        text = '40';
        break;
      case 60:
        text = '60';
        break;
      case 80:
        text = '80';
        break;
      case 100:
        text = '100';
        break;

      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 8,
    );

    //load data from apiChart date
    String text = labels[value.toInt()];

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 20,
      child: Transform.rotate(angle: -120, child: Text(text, style: style)),
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: Colors.black.withOpacity(0.2), width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarTemperature => LineChartBarData(
          isCurved: true,
          color: Colors.red,
          barWidth: 8,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
          spots: [
            for (int i = 0; i < widget.apiChart['data'].length; i++)
              FlSpot(i.toDouble(),
                  double.parse(widget.apiChart['data'][i][0]["value"]))
          ]);

  LineChartBarData get lineChartBarDataHumidity => LineChartBarData(
        isCurved: true,
        color: Colors.blue,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
          color: Colors.pink.withOpacity(0),
        ),
        spots: [
          for (int i = 0; i < widget.apiChart['data'].length; i++)
            FlSpot(i.toDouble(),
                double.parse(widget.apiChart['data'][i][1]["value"]))
        ],
      );

  LineChartBarData get lineChartBarDataLight => LineChartBarData(
        isCurved: true,
        color: Colors.orange,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: [
          for (int i = 0; i < widget.apiChart['data'].length; i++)
            FlSpot(i.toDouble(),
                double.parse(widget.apiChart['data'][i][2]["value"]))
        ],
      );

  LineChartBarData get lineChartBarDataSoilMoisture => LineChartBarData(
        isCurved: true,
        color: Colors.green,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: [
          for (int i = 0; i < widget.apiChart['data'].length; i++)
            FlSpot(i.toDouble(),
                double.parse(widget.apiChart['data'][i][3]["value"]))
        ],
      );
}
