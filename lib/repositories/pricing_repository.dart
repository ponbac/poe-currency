import 'dart:async';

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

  Future<List<PricedObject>> getPricesForCurrency() async {
    var prices = new List<PricedObject>();

    for (String cc in currencyCategories) {
      var results = await pricingApiClient.fetchCurrencyOverview(cc);
      prices..addAll(results);
    }

    for (String ic in itemCategories) {
      var results = await pricingApiClient.fetchItemOverview(ic);
      prices..addAll(results);
    }

    return prices;
  }
}
