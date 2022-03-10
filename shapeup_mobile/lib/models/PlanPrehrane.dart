import 'dart:convert';
import 'dart:typed_data';

class PlanPrehrane {
  String opis;
  String nutritivneVrijednosti;
  Uint8List? slika;

  PlanPrehrane({
    required this.opis,
    required this.nutritivneVrijednosti,
    this.slika
  });

  factory PlanPrehrane.fromJson(Map<String, dynamic> json){
    String stringByte = json["slika"] as String;
    List<int> bytes = base64Decode(stringByte);
    Uint8List list = Uint8List.fromList(bytes);
    return PlanPrehrane(opis: json['opis'], nutritivneVrijednosti: json['nutritivneVrijednosti'], slika: list);
  }

  Map<String, dynamic> toJson() => {'opis': opis, 'nutritivneVrijednosti': nutritivneVrijednosti, 'slika': slika};
}