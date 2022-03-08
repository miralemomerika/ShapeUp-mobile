import 'package:flutter/material.dart';

class TreningDetalji extends StatefulWidget {
  const TreningDetalji({Key? key}) : super(key: key);

  @override
  _TreningDetaljiState createState() => _TreningDetaljiState();
}

class _TreningDetaljiState extends State<TreningDetalji> {

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
              child: Text('Detalji treninga'),
            ),
          ),
        ],
      ),
    );
  }
}