import 'package:flutter/material.dart';
import 'package:shapeup_mobile/models/Proizvod.dart';
import 'package:shapeup_mobile/pages/PaymentForm.dart';

class ProizvodiDetalji extends StatefulWidget {
  final Proizvod proizvod;

  const ProizvodiDetalji({Key? key, required this.proizvod}) : super(key: key);

  @override
  _ProizvodiDetaljiState createState() => _ProizvodiDetaljiState();
}

class _ProizvodiDetaljiState extends State<ProizvodiDetalji> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Detalji proizvoda'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey))),
                child: imageShow()),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Text(
                widget.proizvod.naziv,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Arial',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(30, 0, 0, 10),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Kratki opis:',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Arial',
                            fontWeight: FontWeight.bold),
                      )),
                  Text(
                    widget.proizvod.opis,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Arial',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(50),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PaymentForm(proizvod: widget.proizvod)))
                      .then((_) => {setState(() {})});
                },
                child: Image(
                  width: 100,
                  height: 100,
                  image: AssetImage('assets/korpa.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageShow() {
    if (widget.proizvod.slika != null && widget.proizvod.slika!.isNotEmpty) {
      return Image(image: MemoryImage(widget.proizvod.slika!));
    }
    return Image(image: AssetImage('assets/no-image.png'));
  }
}
