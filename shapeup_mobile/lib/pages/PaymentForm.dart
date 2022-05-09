import 'package:flutter/material.dart';
import 'package:shapeup_mobile/models/PaymentModel.dart';
import 'package:shapeup_mobile/models/Proizvod.dart';
import 'package:shapeup_mobile/services/HttpService.dart';

class PaymentForm extends StatefulWidget {
  final Proizvod proizvod;

  const PaymentForm({Key? key, required this.proizvod}) : super(key: key);

  @override
  _PaymentFormState createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  TextEditingController creditCardController = new TextEditingController();
  TextEditingController expYearController = new TextEditingController();
  TextEditingController expMonthController = new TextEditingController();
  TextEditingController cvcController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController amountController = new TextEditingController();
  TextEditingController issuingCardController = new TextEditingController();
  
  late bool successful;


  @override
  void initState() {
    super.initState();
    amountController.text = widget.proizvod.cijena.toString();
  }

  @override
  Widget build (BuildContext context) {
     return Scaffold(
       appBar: AppBar(
        title: Text('Plaćanje'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(60, 20, 60, 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: creditCardController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                      hintText: 'Kartica'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: expYearController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                    hintText: 'Godina isteka'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: expMonthController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                    hintText: 'Mjesec isteka'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: cvcController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                    hintText: 'CVC'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                    hintText: 'Ime'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                    hintText: 'Adresa'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: issuingCardController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                    hintText: 'Izdavac kartice'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  enabled: false,
                  controller: amountController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                    hintText: 'Cijena'),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.purple[700],
                    borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    child: Text(
                      'Plati',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () async {
                      await Pay();
                      if(successful == true){
                        showDialog<String>(
                          context: context, 
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Potvrda!'),
                            content: const Text('Uplata uspjesno izvrsena.'),
                            actions: <Widget>[
                              TextButton(onPressed: () => Navigator.of(context).pushReplacementNamed('/products'), child: const Text('Ok'),
                              ),
                            ],
                          ),
                        );
                      }
                      else{
                        showDialog<String>(
                          context: context, 
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Pogreska!'),
                            content: const Text('Greska prilikom placanja.'),
                            actions: <Widget>[
                              TextButton(onPressed: () => Navigator.of(context).pushReplacementNamed('/products'), child: const Text('Ok'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> Pay() async {
    
    var uplata = PaymentModal(
      number: creditCardController.text,
      cvc: cvcController.text,
      name: nameController.text,
      currency: 'BAM',
      addressCity: addressController.text,
      expYear: int.parse(expYearController.text),
      expMonth: int.parse(expMonthController.text),
      amount: double.parse(amountController.text).round() * 100,
      issuingCard:  issuingCardController.text,
      description: widget.proizvod.naziv,
    );

    print(uplata.toJson());

    var response = await HttpService.PostObj("Payment/ProccessPayment", uplata.toJson());
    if(response == null) {
      setState(() {
        successful = false;
      });
      return;
    }
    if(response == "500") {
      setState(() {
        successful = false;
      });
      return;
    }
    
    if(response != null || response == '200'){
      setState(() {
        successful = true;
      });
      return true;
    }
  }
}