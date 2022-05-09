class NapredakDto {
  int tezina;
  String datum;

  NapredakDto({
    required this.tezina,
    required this.datum
  });

  factory NapredakDto.fromJson(Map<String, dynamic> json){
    return NapredakDto(tezina: json['tezina'], datum: json['datum']);
  }

  Map<String, dynamic> toJson() => {'tezina':tezina, 'datum':datum};
}