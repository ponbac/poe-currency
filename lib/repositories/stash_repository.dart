import 'dart:async';

import 'package:meta/meta.dart';
import 'package:poe_currency/models/stash.dart';
import 'package:poe_currency/models/stash_tab.dart';
import 'package:poe_currency/repositories/stash_api_client.dart';

class StashRepository {
  final StashApiClient stashApiClient;

  StashRepository({@required this.stashApiClient})
      : assert(stashApiClient != null);

  Future<Stash> getStash(String accountName, String sessionId) async {
    Stash stash = new Stash();

    int stashTabIndex = 0;
    StashTab currentStashTab =
        await stashApiClient.fetchStashTab(accountName, sessionId, stashTabIndex);
    while (currentStashTab != null) {
      stash.addStashTab(currentStashTab);
      stashTabIndex++;
      currentStashTab = await stashApiClient.fetchStashTab(accountName, sessionId, stashTabIndex);
    }

    return stash;
  }
}
