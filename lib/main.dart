import 'dart:math';

import 'package:flutter/material.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:vector_math/vector_math_64.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: Home(),
    );
  }
}

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

  @override
  void initState() {
    super.initState();
    motionSensors.magnetometer.listen((MagnetometerEvent event) {
      // print(event);
      setState(() {
        _magnetometer.setValues(event.x, event.y, event.z);
        var matrix =
            motionSensors.getRotationMatrix(_accelerometer, _magnetometer);
        _absoluteOrientation2.setFrom(motionSensors.getOrientation(matrix));
      });
    });
  }

  void setUpdateInterval(int? groupValue, int interval) {
    motionSensors.magnetometerUpdateInterval = interval;

    setState(() {
      _groupValue = groupValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000000),
      appBar: AppBar(
        title: const Text('Motion Sensors'),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                textWidget('x: ${_magnetometer.x.toStringAsFixed(4)}'),
                textWidget('y: ${_magnetometer.y.toStringAsFixed(4)}'),
                textWidget('z: ${_magnetometer.z.toStringAsFixed(4)}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget textWidget(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
