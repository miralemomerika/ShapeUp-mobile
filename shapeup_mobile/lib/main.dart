import 'package:flutter/material.dart';
import 'package:shapeup_mobile/pages/Login.dart';
import 'package:shapeup_mobile/pages/Dashboard.dart';
import 'package:shapeup_mobile/pages/Trainings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Login(),
        routes: {
          '/dashboard': (context) => Dashboard(),
          '/login': (context) => Login(),
          '/workouts': (context) => Trainings(),
        },
      );
  }
}