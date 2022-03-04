class Klijent {
  final String id;
  final String email;
  String? firstName;
  String? lastName;
  String? userName;
  String? phoneNumber;
  String? password;
  String? role;

  Klijent({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.userName,
    this.phoneNumber,
    this.password,
    this.role
  });

  factory Klijent.fromJson(Map<String, dynamic> json){
    return Klijent(id: json["id"], email: json["email"]);
  }

  Map<String, dynamic> toJson() => {
    "email": email,
    "firstName": firstName,
    "lastName": lastName,
    "userName": userName,
    "phoneNumber": phoneNumber,
    "password": password,
    "role": role
  };
}