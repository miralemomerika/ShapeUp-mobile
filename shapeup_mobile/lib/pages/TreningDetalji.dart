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
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey, width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Pokreni video'),
                      Icon(Icons.play_arrow),
                    ],
                  ),
                ),
                
              ),
              Text(widget.trening.opis),
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