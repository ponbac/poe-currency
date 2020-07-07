import 'dart:async';

import 'package:meta/meta.dart';
import 'package:poe_currency/models/pricing/priced_currency.dart';
import 'package:poe_currency/repositories/pricing_api_client.dart';

class PricingRepository {
  final PricingApiClient pricingApiClient;

  PricingRepository({@required this.pricingApiClient})
      : assert(pricingApiClient != null);

  Future<List<PricedCurrency>> getPricesForCurrency() async {
    var prices = await pricingApiClient.fetchCurrencyOverview();

    return prices;
  }

  /*var categories = [
    'Currency',
    'Fragment',
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
  ];*/
}
