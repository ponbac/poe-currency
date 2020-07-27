import 'dart:collection';

import 'package:poe_currency/models/stash_tab.dart';
import 'package:poe_currency/models/item.dart';

class Stash {
  List<StashTab> _tabs;
  List<Item> _allItems;
  HashMap<String, Item> _idItemMap;

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
      _idItemMap = HashMap.fromIterable(stashTab.items,
          key: (i) => _getUniqueItemIdentifier(i), value: (i) => i);
    } else {
      // Stack items spread between different stash tabs
      stashTab.items.forEach((item) {
        String uniqueKey = _getUniqueItemIdentifier(item);

        if (_idItemMap.containsKey(uniqueKey)) {
          if (_idItemMap[uniqueKey].stackSize != null) {
            _idItemMap[uniqueKey].stackSize += item.stackSize;
          }
          if (!_idItemMap[uniqueKey].tabs.contains(item.tabs[0])) {
            _idItemMap[uniqueKey].tabs.add(item.tabs[0]);
          }
          _allItems
              .removeWhere((i) => _getUniqueItemIdentifier(i) == uniqueKey);
          _allItems.add(_idItemMap[uniqueKey]);
        } else {
          _allItems.add(item);
        }
      });
    }
  }

  // TODO: Make part of Item class instead?
  String _getUniqueItemIdentifier(Item i) {
    return (i.typeLine ?? '') + (i.name ?? '');
  }

  List<StashTab> get tabs {
    return _tabs;
  }

  List<Item> get allItems {
    return _allItems;
  }
}
