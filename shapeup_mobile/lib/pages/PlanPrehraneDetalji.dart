import 'package:flutter/material.dart';

class PlanPrehranDetalji extends StatefulWidget {
  const PlanPrehranDetalji({Key? key}) : super(key: key);

  @override
  _PlanPrehranDetaljiState createState() => _PlanPrehranDetaljiState();
}

class _PlanPrehranDetaljiState extends State<PlanPrehranDetalji> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Text('Detalji plana prehrane'),
            ),
          ),
        ],
      ),
    );
  }
}