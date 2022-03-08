class Cilj {
  final int id;
  final String name;

  Cilj({
    required this.id,
    required this.name
  });

  factory Cilj.fromJson(Map<String, dynamic> json){
    return Cilj(id: int.parse(json["id"].toString()), name: json["name"]);
  }

  Map<String, dynamic> toJson() => {"id":id, "name":name};
}