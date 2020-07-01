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
        '$baseUrl/character-window/get-stash-items?league=Harvest&tabs=1&tabIndex=$stashIndex&accountName=$accountName';

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

    return new StashTab(
        name: name, type: type, index: stashIndex, items: items);
  }

  Future<StashTab> fetchStashTabWeb(String accountName, int stashIndex) async {
    final proxyUrl = 'https://poe-api-proxy.herokuapp.com/get/';
    final requestUrl = '$proxyUrl$baseUrl/character-window/get-stash-items?league=Harvest&tabs=1&tabIndex=$stashIndex&accountName=$accountName';

    //print(requestUrl);

    var rawData = await http.get(requestUrl);

    //print(rawData.body);

    var name, type, items;

    try {
      name = jsonDecode(rawData.body)['tabs'][0]['n'];
      type = jsonDecode(rawData.body)['tabs'][0]['type'];
      items = (jsonDecode(rawData.body)['items'] as List)
          .map((item) => Item.fromJson(item))
          .toList();
    } catch (_) {
      return null;
    }

    return new StashTab(name: name, type: type, index: stashIndex, items: items);
  }
}
