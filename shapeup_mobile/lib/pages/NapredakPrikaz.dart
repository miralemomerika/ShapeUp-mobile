import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:shapeup_mobile/models/NapredakDto.dart';
import 'package:shapeup_mobile/services/HttpService.dart';

class NapredakPrikaz extends StatefulWidget {
  const NapredakPrikaz({Key? key}) : super(key: key);

  @override
  _NapredakPrikaz createState() => _NapredakPrikaz();
}

class _NapredakPrikaz extends State<NapredakPrikaz> {
  TextEditingController weightController = new TextEditingController();
  late DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Napredak'),
      ),
      body: Column(
        
        children: [
          Card(
            elevation: 5,
            margin: EdgeInsets.fromLTRB(10, 40, 10, 10),
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(color: Colors.blue[50]),
              child: Row(
                children: [
                  SizedBox(
                    width: 200,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 20.0),
                          child: TextField(
                            
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                              fontSize: 16
                            ),
                            controller: weightController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                                hintText: 'Tjelesna tezina'),
                          ),
                        ),
                        Container(
                          child: DateTimeFormField(
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.black45),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.event_note),
                              labelText: 'Datum',
                            ),
                            mode: DateTimeFieldPickerMode.date,
                            autovalidateMode: AutovalidateMode.always,
                            onDateSelected: (DateTime value) {
                              setState(() {
                                selectedDate = value;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.blue[200], 
                      borderRadius: BorderRadius.circular(20)
                      ),
                    child: TextButton(
                      child: Text("Spasi", style: TextStyle(color: Colors.white),), 
                      onPressed: () {
                        PostNapredak();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> PostNapredak() async {
    String month = (selectedDate.month.toString().length == 1) ? "0"+selectedDate.month.toString():selectedDate.month.toString();
    String datum = selectedDate.year.toString()+"-"+month+"-"+selectedDate.day.toString();

    var napredak = NapredakDto(
      tezina: int.parse(weightController.text),
      datum: datum
    );

    print(napredak.toJson().toString());

    var response = await HttpService.PostObj("Napredak", napredak.toJson());
    if(response == null) return;
    if(response == "500") return;
    
    if(response != null || response == '200'){
      return true;
    }
  }
}