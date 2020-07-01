import 'package:poe_currency/models/stash_tab.dart';

class Stash {
  List<StashTab> _tabs;

  Stash();

  void addStashTab(StashTab stashTab) {
    if (_tabs == null) {
      _tabs = new List()..add(stashTab);
    } else {
      if (!_tabs.contains(stashTab)) {
        _tabs.add(stashTab);
      }
    }
  }

  List<StashTab> get tabs {
    return _tabs;
  }
}
