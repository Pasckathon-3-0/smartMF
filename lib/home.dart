import 'dart:math';

import 'package:emf_app/utils/colors.dart';
import 'package:emf_app/widgets/textWidget.dart';
import 'package:flutter/material.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:vector_math/vector_math_64.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Vector3 _magnetometer = Vector3.zero();
  Vector3 _accelerometer = Vector3.zero();
  Vector3 _absoluteOrientation2 = Vector3.zero();
  int? _groupValue = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   motionSensors.magnetometer.listen((MagnetometerEvent event) {
  //     // print(event);
  //     setState(() {
  //       _magnetometer.setValues(event.x, event.y, event.z);
  //       var matrix =
  //           motionSensors.getRotationMatrix(_accelerometer, _magnetometer);
  //       _absoluteOrientation2.setFrom(motionSensors.getOrientation(matrix));
  //     });
  //   });
  // }

  void setUpdateInterval(int? groupValue, int interval) {
    motionSensors.magnetometerUpdateInterval = interval;

    setState(() {
      _groupValue = groupValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              sqrt((pow(_magnetometer.x, 2)) +
                          (pow(_magnetometer.y, 2)) +
                          (pow(_magnetometer.z, 2)))
                      .toStringAsFixed(2) +
                  ' μTesla',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            Text('Update Interval'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: 1,
                  groupValue: _groupValue,
                  onChanged: (dynamic value) => setUpdateInterval(
                      value, Duration.microsecondsPerSecond ~/ 1),
                ),
                Text("1 FPS"),
                Radio(
                  value: 2,
                  groupValue: _groupValue,
                  onChanged: (dynamic value) => setUpdateInterval(
                      value, Duration.microsecondsPerSecond ~/ 30),
                ),
                Text("30 FPS"),
                Radio(
                  value: 3,
                  groupValue: _groupValue,
                  onChanged: (dynamic value) => setUpdateInterval(
                      value, Duration.microsecondsPerSecond ~/ 60),
                ),
                Text("60 FPS"),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                textWidget('x: ${_magnetometer.x.toStringAsFixed(2)}'),
                textWidget('y: ${_magnetometer.y.toStringAsFixed(2)}'),
                textWidget('z: ${_magnetometer.z.toStringAsFixed(2)}'),
              ],
            ),
            SizedBox(height: 20),
            SfRadialGauge(axes: <RadialAxis>[
              RadialAxis(minimum: 0, maximum: 150, ranges: <GaugeRange>[
                GaugeRange(startValue: 0, endValue: 50, color: AppColors.green),
                GaugeRange(
                    startValue: 50, endValue: 100, color: AppColors.orange),
                GaugeRange(startValue: 100, endValue: 150, color: AppColors.red)
              ], pointers: <GaugePointer>[
                NeedlePointer(
                    value: sqrt((pow(_magnetometer.x, 2)) +
                        (pow(_magnetometer.y, 2)) +
                        (pow(_magnetometer.z, 2))))
              ], annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    widget: Container(
                        child: Text('90.0',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold))),
                    angle: 90,
                    positionFactor: 0.5)
              ])
            ])
          ],
        ),
      ),
    );
  }
}
