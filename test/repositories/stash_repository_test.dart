import 'package:poe_currency/models/stash.dart';
import 'package:poe_currency/repositories/stash_api_client.dart';
import 'package:poe_currency/repositories/stash_repository.dart';
import 'package:poe_currency/repositories/stash_repository_web.dart';
import 'package:poe_currency/secrets.dart';
import "package:test/test.dart";

void main() {

  
  test('Test if StashRepository returns a complete stash.', () async {
    var stashRepository = StashRepository(stashApiClient: new StashApiClient());

    Stash stash = await stashRepository.getStash('Zedimus', poeSessionId);

    /*int index = 0;
    items.forEach((item) {
      print('$index: $item');
      index++;
    });*/

    expect(stash.tabs.length, equals(23));
    expect(stash.tabs[0].items.length, greaterThan(1));
  });

  test('Test if StashRepository returns a complete stash for web.', () async {
    var stashRepositoryWeb = StashRepositoryWeb(stashApiClient: new StashApiClient());

    Stash stash = await stashRepositoryWeb.getStash('Zedimus', poeSessionId);

    /*int index = 0;
    items.forEach((item) {
      print('$index: $item');
      index++;
    });*/

    expect(stash.tabs[0].items.length, greaterThan(1));
  });
}