import 'package:emf_app/models/magnitudeProvider.dart';
import 'package:emf_app/utils/colors.dart';
import 'package:emf_app/widgets/mainReading.dart';
import 'package:emf_app/widgets/meterReading.dart';
import 'package:emf_app/widgets/startButton.dart';
import 'package:emf_app/widgets/xyzReading.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MainReading(),
            XYZReading(),
            MeterReading(),
            // StartButton()
          ],
        ),
      ),
    );
  }
}
