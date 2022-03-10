import 'dart:convert';
import 'dart:typed_data';

class Proizvod{
  String naziv;
  String opis;
  double? prosjecnaOcjena;
  double cijena;
  int kategorijaProizvodaId;
  Uint8List? slika;

  Proizvod({
    required this.naziv,
    required this.opis,
    this.prosjecnaOcjena,
    required this.cijena,
    required this.kategorijaProizvodaId,
    this.slika
  });

  factory Proizvod.fromJson(Map<String, dynamic> json) {
    String stringByte = json['slika'] as String;
    List<int> byte = base64Decode(stringByte);
    Uint8List list = Uint8List.fromList(byte);
    return Proizvod(naziv: json['naziv'], opis: json['opis'], prosjecnaOcjena: double.parse(json['prosjecnaOcjena'].toString()), 
      cijena: double.parse(json['cijena'].toString()), kategorijaProizvodaId: int.parse(json['kategorijaProizvodaId'].toString()),
      slika: list);
  }

  Map<String, dynamic> toJson() => {
    'naziv': naziv,
    'opis': opis,
    'prosjecnaOcjena': prosjecnaOcjena,
    'cijena': cijena,
    'kategorijaProizvodaId': kategorijaProizvodaId,
    'slika': slika,
  };
}