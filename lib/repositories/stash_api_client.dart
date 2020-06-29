import 'dart:io';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:poe_currency/models/item.dart';

class StashApiClient {
  static const baseUrl = 'https://www.pathofexile.com';
  final HttpClient httpClient;

  StashApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<List<Item>> getStashTab(
      String accountName, String sessionId, int stashIndex) async {
    final requestUrl =
        '$baseUrl/character-window/get-stash-items?league=Harvest&tabs=1&tabIndex=$stashIndex&accountName=$accountName';

    String rawData = await _getParsedResponseFromUrlWithSessionId(requestUrl, sessionId);

    var items = (jsonDecode(rawData)['items'] as List)
      .map((item) => Item.fromJson(item))
      .toList();

    return items;
  }

  Future<String> _readResponse(HttpClientResponse response) {
    final completer = Completer<String>();
    final contents = StringBuffer();

    response.transform(utf8.decoder).listen((data) {
      contents.write(data);
    }, onDone: () => completer.complete(contents.toString()));

    return completer.future;
  }

  Future<String> _getParsedResponseFromUrlWithSessionId(String url, String sessionId) async {
    HttpClientRequest clientRequest =
        await httpClient.getUrl(Uri.parse(url));
    clientRequest.cookies.add(Cookie("POESESSID", sessionId));
    HttpClientResponse clientResponse = await clientRequest.close();

    if (clientResponse.statusCode != 200) {
      throw Exception('error getting stash tab');
    }

    return await _readResponse(clientResponse);
  }
}