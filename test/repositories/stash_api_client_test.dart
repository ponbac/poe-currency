import 'package:poe_currency/models/stash_tab.dart';
import 'package:poe_currency/repositories/stash_api_client.dart';
import 'package:poe_currency/secrets.dart';
import "package:test/test.dart";

void main() {
  
  test('Test if the API returns a valid stash tab.', () async {
    var apiClient = StashApiClient();

    StashTab stashTab = await apiClient.fetchStashTab('Zedimus', poeSessionId, 0);

    /*int index = 0;
    items.forEach((item) {
      print('$index: $item');
      index++;
    });*/

    expect(stashTab.items.length, greaterThan(1));
    expect(stashTab.name.length, greaterThan(0));
  });

  test('Test if the API returns a valid stash tab for web.', () async {
    var apiClient = StashApiClient();

    StashTab stashTab = await apiClient.fetchStashTabWeb('Zedimus', poeSessionId, 0);

    /*int index = 0;
    items.forEach((item) {
      print('$index: $item');
      index++;
    });*/

    expect(stashTab.items.length, greaterThan(1));
    expect(stashTab.name.length, greaterThan(0));
  });
}