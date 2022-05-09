import 'package:flutter/material.dart';
import 'package:shapeup_mobile/models/Proizvod.dart';
import 'package:shapeup_mobile/pages/ProizvodDetalji.dart';
import 'package:shapeup_mobile/services/HttpService.dart';

class ProizvodiPrikaz extends StatefulWidget {
  const ProizvodiPrikaz({Key? key}) : super(key: key);

  @override
  _ProizvodiPrikaz createState() => _ProizvodiPrikaz();
}

class _ProizvodiPrikaz extends State<ProizvodiPrikaz> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Suplementi'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.all(20), 
              child: Text('Proizvodi by Proteini.si',
                style: TextStyle(
                  color: Colors.blueGrey[900], 
                  fontSize: 25, 
                  fontFamily: 'Arial',
                ),
              ),
            ),
          ),
          Expanded(
            child: proizvodi(),
          ),
        ],
      ),
    );
  }

  Widget proizvodi() {
    return FutureBuilder<List<Proizvod>>(
      future: GetProizvodi(),
      builder: (BuildContext context, AsyncSnapshot<List<Proizvod>> snapshot) {
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
                children: snapshot.data!.map((e) => proizvodCard(e)).toList()
              ),
            );
          }
        }
      }
    );
  }

  Future<List<Proizvod>> GetProizvodi () async {
    var results = await HttpService.Get('Proizvodi', null);

    return results!.map((e) => Proizvod.fromJson(e)).toList();
  }

  Widget proizvodCard (proizvod) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ProizvodiDetalji(proizvod: proizvod))).then((_) => { setState(() { })});
        },
        child: Padding(padding: EdgeInsets.all(0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: imageShow(proizvod)
              ),
              Flexible( 
                child: Container(
                  height: 100,
                  padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        alignment: Alignment.topCenter,
                        child: Text(proizvod.naziv, style: TextStyle(color: Colors.blueGrey[900], fontSize: 18, fontWeight: FontWeight.bold),),
                      ),
                      Container(
                        height: 40,
                        alignment: Alignment.bottomRight,
                        child: Text((proizvod.cijena).toString() + ' KM', style: TextStyle(color: Colors.blueGrey[900], fontSize: 16),),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageShow (proizvod) {
    if(proizvod.slika != null && proizvod.slika!.isNotEmpty){
      return Image(image: MemoryImage(proizvod.slika!), width: 100, height: 100,);
    }
    return Image(image: AssetImage('assets/no-image.png'), width: 100, height: 100,);
  }
}