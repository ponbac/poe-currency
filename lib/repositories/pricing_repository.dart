import 'dart:async';
import 'dart:collection';

import 'package:meta/meta.dart';
import 'package:poe_currency/models/pricing/priced_object.dart';
import 'package:poe_currency/models/user/snapshot.dart';
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
    List<PricedObject> completedPrices = [];
    int categoriesLoaded = 0;
    int totalNmbrOfCategories =
        currencyCategories.length + itemCategories.length;

    for (String cc in currencyCategories) {
      pricingApiClient.fetchPriceOverview(cc).then((prices) {
        if (prices != null) {
          completedPrices..addAll(prices);
          categoriesLoaded++;
        } else {
          print(cc + 'is null!');
        }
      });
    }

    for (String ic in itemCategories) {
      pricingApiClient.fetchPriceOverview(ic).then((prices) {
        if (prices != null) {
          completedPrices..addAll(prices);
          categoriesLoaded++;
        } else {
          print(ic + ' is null!');
        }
      });
    }

    await _waitWhile(() => categoriesLoaded != totalNmbrOfCategories);

    // Return HashMap for faster price lookup and also adds Chaos Orb since the API does not return it.
    return HashMap.fromIterable(completedPrices,
        key: (o) => o.name, value: (o) => o.value)
      ..putIfAbsent('Chaos Orb', () => 1.0);
  }

  Future<Snapshot> getLatestSnapshot(String username) async {
    return await pricingApiClient.fetchLatestSnapshot(username);
  }

  Future<List<Snapshot>> getLatestSnapshotsFromList(
      List<String> userList) async {
    List<Snapshot> completedSnapshots = [];
    int snapshotsLoaded = 0;
    int totalNmbrOfSnapshots = userList.length;

    for (String username in userList) {
      pricingApiClient.fetchLatestSnapshot(username).then((snapshot) {
        completedSnapshots.add(snapshot);
        snapshotsLoaded++;
      });
    }

    await _waitWhile(() => snapshotsLoaded != totalNmbrOfSnapshots);

    //print('Loaded: $snapshotsLoaded, Snapshots: $completedSnapshots, Snapshots.length: ${completedSnapshots.length}');

    return completedSnapshots;
  }

  Future<bool> saveSnapshot(String username, int value) async {
    return await pricingApiClient.postSnapshot(username, value);
  }

  // TODO: Code duplication here, this function is also in StashRepo
  Future _waitWhile(bool test(), [Duration pollInterval = Duration.zero]) {
    var completer = new Completer();
    check() {
      if (!test()) {
        completer.complete();
      } else {
        new Timer(pollInterval, check);
      }
    }

    check();
    return completer.future;
  }
}
