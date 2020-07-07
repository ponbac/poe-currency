import 'package:poe_currency/models/pricing/priced_currency.dart';
import 'package:poe_currency/repositories/pricing_api_client.dart';
import 'package:poe_currency/secrets.dart';
import "package:test/test.dart";

void main() {
  
  test('Test if the poeninja API returns prices.', () async {
    var apiClient = PricingApiClient();

    List<PricedCurrency> prices = await apiClient.fetchCurrencyOverview();

    /*int index = 0;
    prices.forEach((price) {
      print('$index: $price');
      index++;
    });*/

    expect(prices.length, greaterThan(5));
  });
}