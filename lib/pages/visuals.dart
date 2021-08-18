import 'dart:async';

import 'package:emf_app/models/magnitudeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Visuals extends StatefulWidget {
  const Visuals({Key? key}) : super(key: key);

  @override
  _VisualsState createState() => _VisualsState();
}

class _VisualsState extends State<Visuals> {
  late ChartSeriesController _chartSeriesController;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visuals'),
      ),
      body: Container(
        child: Column(children: [
          Container(
              height: 300,
              color: Colors.grey.shade800,
              child: Consumer<MagnitudeProvider>(
                builder: (context, model, child) => SfCartesianChart(
                    series: <LineSeries<LiveData, int>>[
                      LineSeries<LiveData, int>(
                        onRendererCreated: (ChartSeriesController controller) {
                          _chartSeriesController = controller;
                        },
                        dataSource: model.values,
                        color: const Color.fromRGBO(192, 108, 132, 1),
                        xValueMapper: (LiveData value, _) => value.time,
                        yValueMapper: (LiveData value, _) => value.x,
                      )
                    ],
                    primaryXAxis: NumericAxis(
                        majorGridLines: const MajorGridLines(width: 0),
                        edgeLabelPlacement: EdgeLabelPlacement.shift,
                        interval: 3,
                        title: AxisTitle(text: 'Time (seconds)')),
                    primaryYAxis: NumericAxis(
                        axisLine: const AxisLine(width: 0),
                        majorTickLines: const MajorTickLines(size: 0),
                        title: AxisTitle(text: 'Internet speed (Mbps)'))),
              ))
        ]),
      ),
    );
  }
}
