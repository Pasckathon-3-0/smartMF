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
            margin: EdgeInsets.all(5),
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Consumer<MagnitudeProvider>(
                  builder: (context, model, child) => SfCartesianChart(
                      title: ChartTitle(text: 'x,y,z with Time'),
                      legend: Legend(
                        isVisible: true,
                        title: LegendTitle(text: 'Legend'),
                      ),
                      series: <LineSeries<LiveData, int>>[
                        //x
                        LineSeries<LiveData, int>(
                          legendItemText: 'x',
                          onRendererCreated:
                              (ChartSeriesController controller) {
                            _chartSeriesController = controller;
                          },
                          dataSource: model.values,
                          color: Colors.red,
                          xValueMapper: (LiveData value, _) => value.time,
                          yValueMapper: (LiveData value, _) => value.x,
                        ),
                        //y
                        LineSeries<LiveData, int>(
                          legendItemText: 'y',
                          onRendererCreated:
                              (ChartSeriesController controller) {
                            _chartSeriesController = controller;
                          },
                          dataSource: model.values,
                          color: Colors.blue,
                          xValueMapper: (LiveData value, _) => value.time,
                          yValueMapper: (LiveData value, _) => value.y,
                        ),
                        //z
                        LineSeries<LiveData, int>(
                          legendItemText: 'z',
                          onRendererCreated:
                              (ChartSeriesController controller) {
                            _chartSeriesController = controller;
                          },
                          dataSource: model.values,
                          color: Colors.green,
                          xValueMapper: (LiveData value, _) => value.time,
                          yValueMapper: (LiveData value, _) => value.z,
                        ),
                      ],
                      primaryXAxis: NumericAxis(
                          majorGridLines: const MajorGridLines(width: 0),
                          edgeLabelPlacement: EdgeLabelPlacement.shift,
                          interval: 3,
                          title: AxisTitle(text: 'Time')),
                      primaryYAxis: NumericAxis(
                          axisLine: const AxisLine(width: 0),
                          majorTickLines: const MajorTickLines(size: 0),
                          title: AxisTitle(text: 'uTesla'))),
                )),
          )
        ]),
      ),
    );
  }
}
