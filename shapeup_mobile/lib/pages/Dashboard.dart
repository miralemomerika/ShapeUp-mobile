import 'package:flutter/material.dart';
import 'package:shapeup_mobile/models/Plan.dart';
import 'package:shapeup_mobile/pages/PlanPrehraneDetalji.dart';
import 'package:shapeup_mobile/services/HttpService.dart';
import 'package:shapeup_mobile/pages/TreningDetalji.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  void initState() {
    super.initState();
    GetPlan();
  }

  var plan = null;

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Pocetna'),
              onTap: () {
                Navigator.of(context).pushNamed('/dashboard');
              }
            ),
            ListTile(
              title: Text('Treninzi'),
              onTap: () {
                Navigator.of(context).pushNamed('/workouts');
              }
            ),
            ListTile(
              title: Text('Obroci'),
              onTap: () {
                Navigator.of(context).pushNamed('/meals');
              }
            ),
            ListTile(
              title: Text('Napredak'),
              onTap: () {
                Navigator.of(context).pushNamed('/progress');
              }
            ),
            ListTile(
              title: Text('Profil'),
              onTap: () {
                Navigator.of(context).pushNamed('/profile');
              }
            ),
            ListTile(
              title: Text('Suplementi'),
              onTap: () {
                Navigator.of(context).pushNamed('/products');
              }
            ),
            ListTile(
              title: Text('Odjavi se', style: TextStyle(color: Colors.red, fontSize: 18),),
              onTap: () {
                HttpService.Logout();
                Navigator.of(context).pushNamed('/login');
              }
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text('Dobrodosli na ShapeUp', style: TextStyle(color: Colors.grey[500], fontSize: 25, fontFamily: 'Arial'),),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(HttpService.role, style: TextStyle(color: Colors.black, fontSize: 50, fontFamily: 'Arial', fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [planWidget()]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget planWidget(){
    if(plan != null) {
      return 
      Column (
        children: [
          Container(
            alignment: Alignment.topLeft,
              child: Text('Danasnji trening:', style: TextStyle(color: Colors.black, fontSize: 20,),), margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
            ),
          Card (
            elevation: 5,
            child: TextButton(
               onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TreningDetalji(trening: plan.trening))).then((_) => { setState(() { })});
              },
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(plan.trening.opis),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text('Danasnji obroci:', style: TextStyle(color: Colors.black, fontSize: 20),), margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
            ),
            Card (
              elevation: 5,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PlanPrehranDetalji(planPrehrane: plan.planPrehrane))).then((_) => { setState(() { })});
              },
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(plan.planPrehrane.opis),
                ),
              ),
            ),
        ],
      );
    }
    else {
      return CircularProgressIndicator();
    }
  }

  void GetPlan () async {
    var plans = await HttpService.Get('Plan', null);

    var list = plans!.map((e) => Plan.fromJson(e)).toList();

    setState(() {plan = list[0]; });
  }
}