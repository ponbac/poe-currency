import 'dart:async';
import 'dart:convert';

import 'package:poe_currency/constants.dart';
import 'package:poe_currency/models/pricing/priced_object.dart';
import 'package:http/http.dart' as http;
import 'package:poe_currency/models/user/snapshot.dart';

class PricingApiClient {
  static const baseUrl = 'https://api.backman.app';

  PricingApiClient();

  Future<List<PricedObject>> fetchPriceOverview(String category) async {
    final requestUrl = '$baseUrl/ninja?league=$CURRENT_PRICING_LEAGUE&type=$category';

    //print(requestUrl);

    var rawData = await http.get(Uri.parse(requestUrl));

    //print(rawData.body);

    var prices;

    try {
      prices = (jsonDecode(rawData.body)['lines'] as List)
          .map((line) => PricedObject.fromJson(line))
          .toList();
    } catch (_) {
      return null;
    }

    return prices;
  }

  Future<Snapshot> fetchLatestSnapshot(String username) async {
    final requestUrl = '$baseUrl/stash/snapshot/latest?username=$username';
    var rawData = await http.get(Uri.parse(requestUrl));

    var snapshot;

    try {
      snapshot = Snapshot.fromJson(jsonDecode(rawData.body));
    } catch (_) {
      print('ERROR: ${_.toString()}');
      return null;
    }

    return snapshot;
  }

  Future<bool> postSnapshot(String username, int value) async {
    final url = '$baseUrl/stash/snapshot/add';
    var map = new Map<String, dynamic>();

    map['username'] = username;
    map['value'] = value.toString();

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: map,
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (_) {
      print('Catch, PricingApiClient: ${_.toString()}');
    }

    return false;
  }
}
