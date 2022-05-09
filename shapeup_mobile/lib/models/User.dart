import 'dart:convert';
import 'dart:typed_data';

class User{
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  Uint8List? slika;
  String? phoneNumber;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.slika,
    this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    String stringByte = json['picture'] as String;
    List<int> byte = base64Decode(stringByte);
    Uint8List list = Uint8List.fromList(byte);
    return User(id: json['id'], firstName: json['firstName'], lastName: json['lastName'], 
      email: json['email'], phoneNumber: json['phoneNumber'], slika: list);
  }
}