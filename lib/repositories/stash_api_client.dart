import 'dart:async';
import 'dart:convert';

import 'package:poe_currency/models/item.dart';
import 'package:http/http.dart' as http;

class StashApiClient {
  static const baseUrl = 'https://www.pathofexile.com';

  StashApiClient();

  Future<List<Item>> getStashTab(
      String accountName, String sessionId, int stashIndex) async {
    final requestUrl =
        '$baseUrl/character-window/get-stash-items?league=Harvest&tabs=1&tabIndex=$stashIndex&accountName=$accountName';

    //print(requestUrl);

    var rawData = await http.get(requestUrl, headers: {
      'COOKIE': 'POESESSID=$sessionId'
    });

    //print(rawData.body);

    var items = (jsonDecode(rawData.body)['items'] as List)
        .map((item) => Item.fromJson(item))
        .toList();

    return items;
  }
}