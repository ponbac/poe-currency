import 'package:poe_currency/models/stash_tab.dart';
import 'package:poe_currency/models/item.dart';


class Stash {
  List<StashTab> _tabs;
  List<Item> _allItems;

  Stash();

  void addStashTab(StashTab stashTab) {
    if (_tabs == null) {
      _tabs = new List()..add(stashTab);
      _copyItemsFromStashTab(stashTab);
    } else {
      if (!_tabs.contains(stashTab)) {
        _tabs.add(stashTab);
        _copyItemsFromStashTab(stashTab);
      }
    }
  }

  // Add all items from given stash tab into the _allItems list.
  void _copyItemsFromStashTab(StashTab stashTab) {
    if (_allItems == null) {
      _allItems = new List()..addAll(stashTab.items);
    } else {
      _allItems.addAll(stashTab.items);
    }
  }

  List<StashTab> get tabs {
    return _tabs;
  }

  List<Item> get allItems {
    return _allItems;
  }
}
