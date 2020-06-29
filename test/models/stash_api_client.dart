import 'dart:io';

import 'package:poe_currency/models/item.dart';
import 'package:poe_currency/repositories/stash_api_client.dart';
import "package:test/test.dart";

void main() {


  test('Test if the API returns a valid stash tab.', () async {
    var apiClient = StashApiClient(httpClient: new HttpClient());

    List<Item> items = await apiClient.getStashTab('Zedimus', 'INSERT_SESS_ID', 0);

    expect(items.length, 51);
  });
}