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

    int nmbrOfTabs = 23;
    int stashTabIndex = 0;
    while (stashTabIndex < nmbrOfTabs) {
      stashApiClient
          .fetchStashTabWeb(accountName, sessionId, stashTabIndex)
          .then((tab) {
        completedTabs.add(tab);
        print('Added: ${tab.items.length}');
      });
      stashTabIndex++;
    }

    return await Future.delayed(const Duration(seconds: 10), () {
      print(
          'Entering delayed future! completedTabs.length = ${completedTabs.length}');

      completedTabs.forEach((tab) {
        if (tab == null || tab.items.length == 0) {
          //print('Tab is empty or null!');
        } else {
          stash.addStashTab(tab);
          print('Added tab: ${tab.name} to stash!');
        }
      });

      print('After for each!');

      return stash;
    });
  }
}
