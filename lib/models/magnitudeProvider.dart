import 'dart:math';

import 'package:flutter/material.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:vector_math/vector_math_64.dart';

class MagnitudeProvider extends ChangeNotifier {
  double x = 0;
  double y = 0;
  double z = 0;

  double magnitude = 0;

  Vector3 magnetometer = Vector3.zero();
  Vector3 _accelerometer = Vector3.zero();
  Vector3 _absoluteOrientation2 = Vector3.zero();
  int? groupValue = 0;

  changeValues() {
    motionSensors.magnetometer.listen((MagnetometerEvent event) {
      magnetometer.setValues(event.x, event.y, event.z);
      var matrix =
          motionSensors.getRotationMatrix(_accelerometer, magnetometer);
      _absoluteOrientation2.setFrom(motionSensors.getOrientation(matrix));
      x = magnetometer.x;
      y = magnetometer.y;
      z = magnetometer.z;
      magnitude = sqrt((pow(magnetometer.x, 2)) +
          (pow(magnetometer.y, 2)) +
          (pow(magnetometer.z, 2)));
      notifyListeners();
    });
  }

  setUpdateInterval(int? groupValue, int interval) {
    motionSensors.magnetometerUpdateInterval = interval;
    groupValue = groupValue;
    notifyListeners();
  }
}
