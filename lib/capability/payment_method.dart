class PaymentMethod {
  String? object;
  String name;
  List? currencies;
  List? cardBrands;
  dynamic installmentTerms;
  List? banks;

  PaymentMethod({
    this.object,
    this.name = '',
    this.currencies,
    this.cardBrands,
    this.installmentTerms,
    this.banks,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        object: json['object'] as String?,
        name: json['name'] as String,
        currencies: json['currencies'] as List?,
        cardBrands: json['card_brands'] as List?,
        installmentTerms: json['installment_terms'] as dynamic,
        banks: json['banks'] as List?,
      );

  Map<String, dynamic> toJson() => {
        'object': object,
        'name': name,
        'currencies': currencies,
        'card_brands': cardBrands,
        'installment_terms': installmentTerms,
        'banks': banks,
      };
}
