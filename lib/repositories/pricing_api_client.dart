import 'dart:async';
import 'dart:convert';

import 'package:poe_currency/models/pricing/priced_object.dart';
import 'package:http/http.dart' as http;
import 'package:poe_currency/models/user/snapshot.dart';

class PricingApiClient {
  static const baseUrl = 'https://poe-api-proxy.herokuapp.com';

  PricingApiClient();

  Future<List<PricedObject>> fetchPriceOverview(String category) async {
    final requestUrl = '$baseUrl/pricing?league=Harvest&type=$category';

    //print(requestUrl);

    var rawData = await http.get(requestUrl);

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
    final requestUrl = '$baseUrl/snapshot/latest?username=$username';
    var rawData = await http.get(requestUrl);

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
    final url = '$baseUrl/snapshot/add';
    var map = new Map<String, dynamic>();

    map['username'] = username;
    map['value'] = value.toString();

    try {
      http.Response response = await http.post(
        url,
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
