class PricedObject {
  String name;
  double value;

  PricedObject({this.name, this.value});

  PricedObject.fromJson(Map<String, dynamic> json) {
    if (json['chaosValue'] == null) {
      name = json['currencyTypeName'];
      value = json['chaosEquivalent'];
    } else {
      name = json['name'];
      value = json['chaosValue'];
    }
  }

  @override
  String toString() {
    return '$name, value: $value';
  }
}
