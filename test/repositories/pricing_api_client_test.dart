import 'package:poe_currency/models/pricing/priced_object.dart';
import 'package:poe_currency/repositories/pricing_api_client.dart';
import "package:test/test.dart";

void main() {
  
  test('Test if the poeninja API returns prices.', () async {
    var apiClient = PricingApiClient();

    List<PricedObject> prices = await apiClient.fetchPriceOverview('Currency');

    /*int index = 0;
    prices.forEach((price) {
      print('$index: $price');
      index++;
    });*/

    expect(prices.length, greaterThan(5));
  });
}