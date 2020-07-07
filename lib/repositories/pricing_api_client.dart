import 'dart:async';
import 'dart:convert';

import 'package:poe_currency/models/pricing/priced_object.dart';
import 'package:http/http.dart' as http;

class PricingApiClient {
  static const baseUrl = 'https://poe.ninja/api/data';

  PricingApiClient();

  // TODO: MAKE API PROXY CACHE PRICES

  Future<List<PricedObject>> fetchCurrencyOverview(String category) async {
    final proxyUrl = 'https://poe-api-proxy.herokuapp.com/get/'; // TODO: CHECK IF NEEDED FOR WEB!
    final requestUrl = '$proxyUrl$baseUrl/currencyoverview?league=Harvest&type=$category';

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

  Future<List<PricedObject>> fetchItemOverview(String category) async {
    final proxyUrl = 'https://poe-api-proxy.herokuapp.com/get/'; // TODO: CHECK IF NEEDED FOR WEB!
    final requestUrl = '$proxyUrl$baseUrl/itemoverview?league=Harvest&type=$category';

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
}
