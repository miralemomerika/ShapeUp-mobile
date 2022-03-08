import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class PlanPrehrane {
  String opis;
  String nutritivneVrijednosti;
  Image? slika;

  PlanPrehrane({
    required this.opis,
    required this.nutritivneVrijednosti,
    this.slika
  });

  factory PlanPrehrane.fromJson(Map<String, dynamic> json){
    return PlanPrehrane(opis: json['opis'], nutritivneVrijednosti: json['nutritivneVrijednosti'], slika: Image.memory(Uint8List.fromList(utf8.encode(json['slika']))));
  }

  Map<String, dynamic> toJson() => {'opis': opis, 'nutritivneVrijednosti': nutritivneVrijednosti, 'slika': slika};
}