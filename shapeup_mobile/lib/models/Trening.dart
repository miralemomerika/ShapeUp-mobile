import 'package:flutter/services.dart';

class Trening {
  final int id;
  String opis;
  String? videoUrl;
  int ciljId;
  int kategorijaTreningaId;
  ByteData? slika;

  Trening({
    required this.id,
    required this.opis,
    this.videoUrl,
    required this.ciljId,
    required this.kategorijaTreningaId,
    this.slika
  });

  factory Trening.fromJson(Map<String, dynamic> json){
    return Trening(id: int.parse(json["id"].toString()), opis: json["opis"], ciljId: json["ciljId"], kategorijaTreningaId: json["kategorijaTreningaId"]);
  }

  Map<String, dynamic> toJson() => {"id": id, "opis": opis, "ciljId": ciljId, "kategorijaTreningaId": kategorijaTreningaId};
}