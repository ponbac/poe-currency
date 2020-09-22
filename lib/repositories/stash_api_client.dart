import 'dart:async';
import 'dart:convert';

import 'package:poe_currency/models/item.dart';
import 'package:http/http.dart' as http;
import 'package:poe_currency/models/stash_tab.dart';

class StashApiClient {
  static const baseUrl = 'https://www.pathofexile.com';

  StashApiClient();

  Future<StashTab> fetchStashTab(
      String accountName, String sessionId, int stashIndex) async {
    final requestUrl =
        '$baseUrl/character-window/get-stash-items?league=Heist&tabs=1&tabIndex=$stashIndex&accountName=$accountName';

    //print(requestUrl);

    var rawData =
        await http.get(requestUrl, headers: {'COOKIE': 'POESESSID=$sessionId'});

    //print(rawData.body);

    var name, type, items;

    try {
      name = jsonDecode(rawData.body)['tabs'][stashIndex]['n'];
      type = jsonDecode(rawData.body)['tabs'][stashIndex]['type'];
      items = (jsonDecode(rawData.body)['items'] as List)
          .map((item) => Item.fromJson(item))
          .toList();
    } catch (_) {
      return null;
    }

    // Add tab name as property of each item
    items.forEach((item) => item.tabs.add(name));

    return new StashTab(
        name: name, type: type, index: stashIndex, items: items);
  }

  Future<StashTab> fetchStashTabWeb(
      String accountName, String sessionId, int stashIndex) async {
    final proxyUrl = 'https://poe-currency-api.herokuapp.com';
    final requestUrl =
        '$proxyUrl/stash?league=Heist&tab=$stashIndex&account=$accountName&sessid=$sessionId';

    //print(requestUrl);

    var rawData = await http.get(requestUrl);

    //print(rawData.body);

    var name, type, nmbrOfTabs;
    List<Item> items;

    try {
      name = jsonDecode(rawData.body)['tabs'][stashIndex]['n'];
      type = jsonDecode(rawData.body)['tabs'][stashIndex]['type'];
      nmbrOfTabs = jsonDecode(rawData.body)['numTabs'];
      items = (jsonDecode(rawData.body)['items'] as List)
          .map((item) => Item.fromJson(item))
          .toList();
    } catch (_) {
      return null;
    }

    // Add tab name as property of each item
    items.forEach((item) => item.tabs.add(name));

    // Make icon request go through proxy as well
    items.forEach((i) => i.icon = '$proxyUrl/image?path=${i.icon}');

    return new StashTab(
        name: name, type: type, index: stashIndex, items: items, totalNmbrOfTabs: nmbrOfTabs);
  }
}
