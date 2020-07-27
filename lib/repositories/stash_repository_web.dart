import 'dart:async';

import 'package:meta/meta.dart';
import 'package:poe_currency/models/stash.dart';
import 'package:poe_currency/models/stash_tab.dart';
import 'package:poe_currency/repositories/stash_api_client.dart';
import 'package:poe_currency/repositories/stash_repository.dart';

class StashRepositoryWeb extends StashRepository {
  final StashApiClient stashApiClient;

  StashRepositoryWeb({@required this.stashApiClient})
      : super(stashApiClient: stashApiClient);

  @override
  Future<Stash> getStash(String accountName, String sessionId) async {
    Stash stash = new Stash();
    List<StashTab> completedTabs = new List<StashTab>();

    print('getStash');
    // Fetch first tab to get total number of tabs to fetch.
    StashTab initialTab =
        await stashApiClient.fetchStashTabWeb(accountName, sessionId, 0);
    completedTabs.add(initialTab);

    int nmbrOfTabs = initialTab.totalNmbrOfTabs;
    int stashTabIndex = 1;
    while (stashTabIndex < nmbrOfTabs) {
      stashApiClient
          .fetchStashTabWeb(accountName, sessionId, stashTabIndex)
          .then((tab) {
        completedTabs.add(tab);
        print('Added: ${tab.items.length}');
      });
      stashTabIndex++;
    }

    await waitWhile(() => completedTabs.length != nmbrOfTabs);

    completedTabs.forEach((tab) {
      if (tab == null || tab.items.length == 0) {
        //print('Tab is empty or null!');
      } else {
        stash.addStashTab(tab);
        print('Added tab: ${tab.name} to stash!');
      }
    });

    return stash;
  }

  Future waitWhile(bool test(), [Duration pollInterval = Duration.zero]) {
    var completer = new Completer();
    check() {
      if (!test()) {
        completer.complete();
      } else {
        new Timer(pollInterval, check);
      }
    }

    check();
    return completer.future;
  }
}
