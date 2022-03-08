import 'package:shapeup_mobile/models/Trening.dart';
import 'package:shapeup_mobile/models/PlanPrehrane.dart';
import 'package:shapeup_mobile/models/Mentorstvo.dart';

class Plan {
  String datum;
  Trening trening;
  PlanPrehrane planPrehrane;
  Mentorstvo mentorstvo;
  String klijentId;

  Plan({
    required this.datum,
    required this.trening,
    required this.planPrehrane,
    required this.mentorstvo,
    required this.klijentId
  });

  factory Plan.fromJson(Map<String, dynamic> json){
    return Plan(datum: json['datum'], trening: Trening.fromJson(json['trening']), planPrehrane: PlanPrehrane.fromJson(json['planPrehrane']),
      mentorstvo: Mentorstvo.fromJson(json['mentorstvo']), klijentId: json['klijentId']);
  }

  Map<String, dynamic> toJson() => {'datum': datum, 'trening': trening, 'planPrehrane': planPrehrane, 'mentorstvo': mentorstvo, 'klijentId': klijentId};
}