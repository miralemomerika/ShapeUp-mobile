import 'package:flutter/cupertino.dart';
import 'package:shapeup_mobile/services/HttpService.dart';

class Trainings extends StatefulWidget {
  const Trainings({Key? key}) : super(key: key);

  @override
  _TrainingsState createState() => _TrainingsState();
}

class _TrainingsState extends State<Trainings> {
  TextEditingController _searchTextController = new TextEditingController();
}