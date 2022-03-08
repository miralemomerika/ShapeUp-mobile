class KategTreninga {
  final int id;
  final String name;

  KategTreninga({
    required this.id,
    required this.name
  });

  factory KategTreninga.fromJson(Map<String, dynamic> json){
    return KategTreninga(id: int.parse(json["id"].toString()), name: json["name"]);
  }

  Map<String, dynamic> toJson() => {"id":id, "name":name};
}