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

    int stashTabIndex = 0;
    StashTab currentStashTab = await stashApiClient.fetchStashTabWeb(
        accountName, sessionId, stashTabIndex);
    while (currentStashTab != null) {
      stash.addStashTab(currentStashTab);
      stashTabIndex++;
      currentStashTab = await stashApiClient.fetchStashTabWeb(
          accountName, sessionId, stashTabIndex);
    }

    if (stashTabIndex < 2) {
      throw 'Could not fetch stash!\nControl that you entered a correct account name and session ID.';
    }

    return stash;
  }
}
