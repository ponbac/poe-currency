import 'dart:async';
import 'dart:convert';

import 'package:poe_currency/models/pricing/priced_currency.dart';
import 'package:http/http.dart' as http;

class PricingApiClient {
  static const baseUrl = 'https://poe.ninja/api/data';

  PricingApiClient();

  Future<List<PricedCurrency>> fetchCurrencyOverview() async {
    final requestUrl = '$baseUrl/currencyoverview?league=Harvest&type=Currency';

    //print(requestUrl);

    var rawData = await http.get(requestUrl);

    //print(rawData.body);

    var prices;

    try {
      prices = (jsonDecode(rawData.body)['lines'] as List)
          .map((line) => PricedCurrency.fromJson(line))
          .toList();
    } catch (_) {
      return null;
    }

    return prices;
  }
}
