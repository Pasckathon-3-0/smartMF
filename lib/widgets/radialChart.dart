import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ScatterChartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScatterChartPageState();
}

class _ScatterChartPageState extends State {
  @override
  Widget build(BuildContext context) {
    final List<SalesData> chartData = [
      SalesData(5, 35),
      SalesData(6, 28),
      SalesData(7, 34),
      SalesData(8, 32),
      SalesData(9, 40)
    ];

    return Scaffold(
        body: Center(
            child: Container(
                child: SfSparkLineChart(
      data: <double>[
        1,
        5,
        -6,
        0,
        1,
        -2,
        7,
        -7,
        -4,
        -10,
        13,
        -6,
        7,
        5,
        11,
        5,
        3
      ],
      trackball:
          SparkChartTrackball(activationMode: SparkChartActivationMode.tap),
      //Enable marker
      marker: SparkChartMarker(displayMode: SparkChartMarkerDisplayMode.all),
      //Enable data label
      labelDisplayMode: SparkChartLabelDisplayMode.all,
    ))));
  }
}

class SalesData {
  SalesData(this.y, this.x);
  final double x;
  final double y;
}
