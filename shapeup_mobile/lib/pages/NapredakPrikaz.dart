import 'package:flutter/material.dart';

class NapredakPrikaz extends StatefulWidget {
  const NapredakPrikaz({Key? key}) : super(key: key);

  @override
  _NapredakPrikaz createState() => _NapredakPrikaz();
}

class _NapredakPrikaz extends State<NapredakPrikaz> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Napredak'),
      ),
      body: Center(child: Text('Napredak page.')),
    );
  }
}