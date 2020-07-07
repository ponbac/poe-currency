class PricedCurrency {
  String name;
  double value;

  PricedCurrency({this.name, this.value});

  PricedCurrency.fromJson(Map<String, dynamic> json) {
    name = json['currencyTypeName'];
    value = json['chaosEquivalent'];
  }

  @override
  String toString() {
    return '$name, value: $value';
  }
}