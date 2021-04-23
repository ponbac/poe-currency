import 'package:equatable/equatable.dart';
import 'package:poe_currency/models/item.dart';

class StashTab extends Equatable{
  final String name;
  final String type;
  final int index;
  final List<Item> items;
  final int totalNmbrOfTabs; // TODO: This is probably not information that belongs to a single stash tab.

  StashTab({this.name, this.type, this.index, this.items, this.totalNmbrOfTabs});

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
