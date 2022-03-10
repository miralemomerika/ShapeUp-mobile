import 'package:flutter/material.dart';
import 'package:shapeup_mobile/models/PlanPrehrane.dart';
import 'package:shapeup_mobile/pages/PlanPrehraneDetalji.dart';
import 'package:shapeup_mobile/services/HttpService.dart';

class PlanPrehranePrikaz extends StatefulWidget {
  const PlanPrehranePrikaz({Key? key}) : super(key: key);

  @override
  _PlanPrehranePrikaz createState() => _PlanPrehranePrikaz();
}

class _PlanPrehranePrikaz extends State<PlanPrehranePrikaz> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Obroci'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: EdgeInsets.all(20),
                child: Text('Vasi Obroci', style: TextStyle(color: Colors.blueGrey[900], fontSize: 25, fontFamily: 'Arial'),
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
    return FutureBuilder<List<PlanPrehrane>>(
      future: GetPrehranu(),
      builder: (BuildContext context, AsyncSnapshot<List<PlanPrehrane>> snapshot) {
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
                children: snapshot.data!.map((e) => obrokCard(e)).toList()
              ),
            );
          }
        }
      }
    );
  }

  Widget obrokCard (obrok) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PlanPrehranDetalji(planPrehrane: obrok))).then((_) => { setState(() { })});
        },
        child: Padding(padding: EdgeInsets.all(20),
          child: Text(obrok.opis),
        ),
      ),
    );
  }
   
  Future<List<PlanPrehrane>> GetPrehranu () async {
    var plans = await HttpService.Get('Plan', null);

    return plans!.map((e) => PlanPrehrane.fromJson(e['planPrehrane'])).toList();
  }
}