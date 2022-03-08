class Mentorstvo {
  String datumPocetka;
  String datumZavrsetka;
  String nazivKlijenta;

  Mentorstvo({
    required this.datumPocetka,
    required this.datumZavrsetka,
    required this.nazivKlijenta
  });

  factory Mentorstvo.fromJson(Map<String, dynamic> json){
    return Mentorstvo(datumPocetka: json['datumPocetka'], datumZavrsetka: json['datumZavrsetka'], nazivKlijenta: json['nazivKlijenta']);
  }

  Map<String, dynamic> toJson() => {'datumPocetka': datumPocetka, 'datumZavrsetka': datumZavrsetka, 'nazivKlijenta': nazivKlijenta};
}