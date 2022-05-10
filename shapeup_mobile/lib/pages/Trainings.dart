import 'package:flutter/material.dart';
import 'package:shapeup_mobile/models/Trening.dart';
import 'package:shapeup_mobile/pages/TreningDetalji.dart';
import 'package:shapeup_mobile/services/HttpService.dart';

class Trainings extends StatefulWidget {
  const Trainings({Key? key}) : super(key: key);

  @override
  _TrainingsState createState() => _TrainingsState();
}

class _TrainingsState extends State<Trainings> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Treninzi'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: EdgeInsets.all(20),
                child: Text('Vaši Treninzi', style: TextStyle(color: Colors.blueGrey[900], fontSize: 25, fontFamily: 'Arial'),
              )
            ),
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
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TreningDetalji(trening: trening))).then((_) => { setState(() { })});
        },
        child: Padding(padding: EdgeInsets.all(20),
          child: Text((trening.opis),style: TextStyle(fontSize: 15,color: Colors.lightBlue,fontWeight: FontWeight.normal)),
        ),
      ),
    );
  }

  Future<List<Trening>> GetTreninge () async {
    var plans = await HttpService.Get('Plan', null);

    return plans!.map((e) => Trening.fromJson(e['trening'])).toList();
  }
}