import 'dart:io';

import 'package:poe_currency/models/item.dart';
import 'package:poe_currency/repositories/stash_api_client.dart';
import 'package:poe_currency/secrets.dart';
import "package:test/test.dart";

void main() {

  
  test('Test if the API returns a valid stash tab.', () async {
    var apiClient = StashApiClient(httpClient: new HttpClient());

    List<Item> items = await apiClient.getStashTab('Zedimus', POE_SESSION_ID, 0);

    int index = 0;
    items.forEach((item) {
      print('$index: $item');
      index++;
    });

    expect(items.length, 51);
  });
}