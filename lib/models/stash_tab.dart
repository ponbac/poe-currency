import 'package:equatable/equatable.dart';
import 'package:poe_currency/models/item.dart';

class StashTab extends Equatable{
  final String name;
  final String type;
  final int index;
  final List<Item> items;

  StashTab({this.name, this.type, this.index, this.items});

  @override
  List<Object> get props => [name, items];

  int get totalValue {
    double value = 0;

    items.forEach((item) {
      value += item.totalValue;
    });

    return value.round();
  }
}
