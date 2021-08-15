// import 'package:emf_app/models/magnitudeProvider.dart';
// import 'package:emf_app/models/startProvider.dart';
// import 'package:emf_app/utils/colors.dart';
// import 'package:emf_app/widgets/textWidget.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_gauges/gauges.dart';

// class StartButton extends StatefulWidget {
//   const StartButton({Key? key}) : super(key: key);

//   @override
//   _StartButtonState createState() => _StartButtonState();
// }

// class _StartButtonState extends State<StartButton> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<StartProvider>(
//       builder: (context, startModel, child) => Consumer<MagnitudeProvider>(
//           builder: (context, model, child) => Container(
//                 width: 120,
//                 child: ElevatedButton(
//                     style: ButtonStyle(
//                         backgroundColor:
//                             MaterialStateProperty.all(Colors.deepPurple)),
//                     onPressed: () {
//                       startModel.changestatus();
//                       startModel.isOn
//                           ? model.changeValues()
//                           : model.doNothing();
//                     },
//                     child: Text(
//                       startModel.isOn ? 'STOP' : 'START',
//                       style: TextStyle(letterSpacing: 1.2),
//                     )),
//               )),
//     );
//   }
// }
