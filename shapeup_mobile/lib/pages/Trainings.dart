import 'package:flutter/material.dart';
import 'package:shapeup_mobile/models/Cilj.dart';
import 'package:shapeup_mobile/models/KategTreninga.dart';
import 'package:shapeup_mobile/models/Trening.dart';
import 'package:shapeup_mobile/pages/TreningDetalji.dart';
import 'package:shapeup_mobile/services/HttpService.dart';

class Trainings extends StatefulWidget {
  const Trainings({Key? key}) : super(key: key);

  @override
  _TrainingsState createState() => _TrainingsState();
}

class _TrainingsState extends State<Trainings> {
  TextEditingController _searchController = new TextEditingController();

  Cilj? _selectedCilj = null;
  List<DropdownMenuItem> ciljevi = [];

  KategTreninga? _selectedKategorija = null;
  List<DropdownMenuItem> kategorije = [];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Treninzi'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text('Vasi Treninzi', style: TextStyle(color: Colors.grey[500], fontSize: 25, fontFamily: 'Arial'),),
          ),
          Expanded(
            child: treninzi(),
          ),
        ],
      ),
    );
  }

  Widget treninzi () {
    return FutureBuilder<List<Trening>>(
      future: GetTreninge(),
      builder: (BuildContext context, AsyncSnapshot<List<Trening>> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(),);
        }
        else {
          if(snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'),);
          }
          else {
            return Container(
              height: 200,
              child: ListView(
                children: snapshot.data!.map((e) => treningCard(e)).toList()
              ),
            );
          }
        }
      }
    );
  }

  Widget treningCard (trening) {
    return Card(
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TreningDetalji(trening: trening))).then((_) => { setState(() { })});
        },
        child: Padding(padding: EdgeInsets.all(20),
          child: Text(trening.opis),
        ),
      ),
    );
  }

  Future<List<Trening>> GetTreninge () async {
    var plans = await HttpService.Get('Plan', null);

    return plans!.map((e) => Trening.fromJson(e['trening'])).toList();
  }
}