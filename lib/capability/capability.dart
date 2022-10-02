import 'payment_method.dart';

class Capability {
  String? object;
  String? location;
  List? banks;
  List<PaymentMethod>? paymentMethods;
  String? country;
  bool? zeroInterestInstallments;

  Capability({
    this.object,
    this.location,
    this.banks,
    this.paymentMethods,
    this.country,
    this.zeroInterestInstallments,
  });

  factory Capability.fromJson(Map<String, dynamic> json) => Capability(
        object: json['object'] as String?,
        location: json['location'] as String?,
        banks: json['banks'] as List?,
        paymentMethods: (json['payment_methods'] as List<dynamic>?)
            ?.map((e) => PaymentMethod.fromJson(e as Map<String, dynamic>))
            .toList(),
        country: json['country'] as String?,
        zeroInterestInstallments: json['zero_interest_installments'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'object': object,
        'location': location,
        'banks': banks,
        'payment_methods': paymentMethods?.map((e) => e.toJson()).toList(),
        'country': country,
        'zero_interest_installments': zeroInterestInstallments,
      };
}
