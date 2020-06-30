import 'dart:async';
import 'dart:convert';

import 'package:poe_currency/models/item.dart';
import 'package:http/http.dart' as http;
import 'package:poe_currency/models/stash_tab.dart';

class StashApiClient {
  static const baseUrl = 'https://www.pathofexile.com';

  StashApiClient();

  Future<StashTab> getStashTab(
      String accountName, String sessionId, int stashIndex) async {
    final requestUrl =
        '$baseUrl/character-window/get-stash-items?league=Harvest&tabs=1&tabIndex=$stashIndex&accountName=$accountName';

    //print(requestUrl);

    var rawData =
        await http.get(requestUrl, headers: {'COOKIE': 'POESESSID=$sessionId'});

    //print(rawData.body);

    var name = jsonDecode(rawData.body)['tabs'][stashIndex]['n'];
    var type = jsonDecode(rawData.body)['tabs'][stashIndex]['type'];
    var items = (jsonDecode(rawData.body)['items'] as List)
        .map((item) => Item.fromJson(item))
        .toList();

    return new StashTab(
        name: name, type: type, index: stashIndex, items: items);
  }
}
