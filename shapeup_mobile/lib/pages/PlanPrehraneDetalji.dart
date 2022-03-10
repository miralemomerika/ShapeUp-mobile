import 'package:flutter/material.dart';
import 'package:shapeup_mobile/models/PlanPrehrane.dart';

class PlanPrehranDetalji extends StatefulWidget {
  final PlanPrehrane planPrehrane;

  const PlanPrehranDetalji({Key? key, required this.planPrehrane}) : super(key: key);

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
      appBar: AppBar(
        title: Text('Detalji plana prehrane'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
              child: imageShow()
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 0, 0, 10), 
                    alignment: Alignment.topLeft, 
                    child: Text('Obroci:', textAlign: TextAlign.left,
                     style: TextStyle(fontSize: 20, 
                      fontFamily: 'Arial', 
                      fontWeight: FontWeight.bold),
                    )
                  ),
                  Text(widget.planPrehrane.opis, 
                    style: TextStyle(fontSize: 16, 
                      fontFamily: 'Arial',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 0, 0, 10), 
                    alignment: Alignment.topLeft, 
                    child: Text('Nutritivne vrijednosti obroka:',
                     style: TextStyle(fontSize: 20, 
                      fontFamily: 'Arial', 
                      fontWeight: FontWeight.bold),
                    )
                  ),
                  Text(widget.planPrehrane.nutritivneVrijednosti, 
                    style: TextStyle(fontSize: 16, 
                      fontFamily: 'Arial',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageShow () {
    if(widget.planPrehrane.slika != null && widget.planPrehrane.slika!.isNotEmpty){
      return Image(image: MemoryImage(widget.planPrehrane.slika!));
    }
    return Image(image: AssetImage('assets/no-image.png'));
  }
}