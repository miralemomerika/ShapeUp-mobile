import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shapeup_mobile/models/Trening.dart';
import 'dart:io' show Platform;
import 'package:url_launcher/url_launcher.dart';

class TreningDetalji extends StatefulWidget {
  final Trening trening;

  const TreningDetalji({Key? key, required this.trening}) : super(key: key);

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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Detalji treninga'),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: [
              Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
                child: imageShow()
              ),
              TextButton(
                onPressed: () => { _launchURL(widget.trening.videoUrl) },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(('Pokreni video'),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold ,color: Colors.lightBlue)),
                      Icon((Icons.play_arrow),color:Colors.lightBlue),
                    ],
                  ),
                ),
                
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 40, 0, 0),
                alignment: Alignment.centerLeft,
                child:Text((widget.trening.opis),style: TextStyle(fontSize: 20,color: Colors.lightBlue)),
              ),
            ],
        ),
      ),
    );
  }

  void _launchURL(url) async {
    if (Platform.isIOS) {
      if (await canLaunch(url)) {
        await launch(url, forceSafariVC: false);
      } else {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch url';
        }
      }
    }
    else {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  Widget imageShow () {
    if(widget.trening.slika != null && widget.trening.slika!.isNotEmpty){
      return Image(image: MemoryImage(widget.trening.slika!));
    }
    return Image(image: AssetImage('assets/no-image.png'));
  }
}