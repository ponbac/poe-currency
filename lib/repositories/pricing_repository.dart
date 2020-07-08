import 'dart:async';
import 'dart:collection';

import 'package:meta/meta.dart';
import 'package:poe_currency/models/pricing/priced_object.dart';
import 'package:poe_currency/repositories/pricing_api_client.dart';

class PricingRepository {
  final PricingApiClient pricingApiClient;

  static const currencyCategories = [
    'Currency',
    'Fragment',
  ];

  static const itemCategories = [
    'Oil',
    'Incubator',
    'Scarab',
    'Fossil',
    'Resonator',
    'Essence',
    'DivinationCard',
    'Prophecy',
    'SkillGem',
    'UniqueMap',
    'Map',
    'UniqueJewel',
    'UniqueFlask',
    'UniqueWeapon',
    'UniqueArmour',
    'Watchstone',
    'UniqueAccessory',
    'DeliriumOrb',
    'Beast',
    'Vial'
  ];

  PricingRepository({@required this.pricingApiClient})
      : assert(pricingApiClient != null);

  Future<HashMap<String, double>> getPricesForCurrency() async {
    var prices = new List<PricedObject>();

    for (String cc in currencyCategories) {
      var results = await pricingApiClient.fetchPriceOverview(cc, PricingObjectType.CURRENCY);
      prices..addAll(results);
    }

    for (String ic in itemCategories) {
      var results = await pricingApiClient.fetchPriceOverview(ic, PricingObjectType.ITEM);
      prices..addAll(results);
    }

    // Return HashMap for faster price lookup and also adds Chaos Orb since the API does not return it.
    return HashMap.fromIterable(prices, key: (o) => o.name, value: (o) => o.value)..putIfAbsent('Chaos Orb', () => 1.0);
  }
}
