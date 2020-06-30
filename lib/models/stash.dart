import 'package:poe_currency/models/stash_tab.dart';

class Stash {
  List<StashTab> _stash;

  Stash();

  void addStashTab(StashTab stashTab) {
    if (stashTab == null) {
      _stash = new List()..add(stashTab);
    } else {
      _stash.add(stashTab);
    }
  }

  List<StashTab> get stash {
    return _stash;
  }
}