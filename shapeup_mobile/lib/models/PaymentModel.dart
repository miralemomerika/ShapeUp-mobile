class PaymentModal {
  String number;
  int expYear;
  int expMonth;
  String cvc;
  String name;
  String currency;
  String addressCity;
  int amount;
  String issuingCard;
  String description;

  PaymentModal({
    required this.number,
    required this.expYear,
    required this.expMonth,
    required this.cvc,
    required this.name,
    required this.currency,
    required this.addressCity,
    required this.amount,
    required this.issuingCard,
    required this.description,
  });

  factory PaymentModal.fromJson(Map<String, dynamic> json){
    return PaymentModal(number: json['number'], expYear: json['expYear'], expMonth: json['expMonth'],
      cvc: json['cvc'], name: json['name'], currency: json['currency'], addressCity: json['addressCity'], amount: json['amount'],
      issuingCard: json['issuingCard'], description: json['description']);
  }

  Map<String, dynamic> toJson() => {'number':number, 'expYear':expYear, 'expMonth':expMonth,
    'cvc':cvc, 'name':name, 'currency':currency, 'addressCity':addressCity, 'amount':amount, 'issuingCard':issuingCard,
    'description':description};
}