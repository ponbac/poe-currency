import 'dart:async';
import 'dart:convert';

import 'package:poe_currency/models/pricing/priced_object.dart';
import 'package:http/http.dart' as http;

class PricingApiClient {
  static const baseUrl = 'https://poe-api-proxy.herokuapp.com/pricing';

  PricingApiClient();

  Future<List<PricedObject>> fetchPriceOverview(String category) async {
    final requestUrl = '$baseUrl?league=Harvest&type=$category';

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
