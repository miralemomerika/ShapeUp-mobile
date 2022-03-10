import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

class Trening {
  final int id;
  String opis;
  String? videoUrl;
  int ciljId;
  int kategorijaTreningaId;
  Uint8List? slika;

  Trening({
    required this.id,
    required this.opis,
    this.videoUrl,
    required this.ciljId,
    required this.kategorijaTreningaId,
    this.slika
  });

  factory Trening.fromJson(Map<String, dynamic> json){
    String stringByte = json["slika"] as String;
    List<int> bytes = base64Decode(stringByte);
    Uint8List list = Uint8List.fromList(bytes);
    return Trening(id: int.parse(json["id"].toString()), opis: json["opis"], ciljId: json["ciljId"],
     kategorijaTreningaId: json["kategorijaTreningaId"], videoUrl: json["videoUrl"], slika: list);
  }

  Map<String, dynamic> toJson() => {"id": id, "opis": opis, "ciljId": ciljId, "kategorijaTreningaId": kategorijaTreningaId};
}