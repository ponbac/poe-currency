import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:equatable/equatable.dart';
import 'package:poe_currency/models/item.dart';
import 'package:poe_currency/models/pricing/priced_object.dart';
import 'package:poe_currency/repositories/pricing_repository.dart';

part 'pricing_event.dart';
part 'pricing_state.dart';

class PricingBloc extends Bloc<PricingEvent, PricingState> {
  final PricingRepository pricingRepository;

  PricingBloc({@required this.pricingRepository})
      : assert(pricingRepository != null),
        super(PricingInitial());

  @override
  Stream<PricingState> mapEventToState(
    PricingEvent event,
  ) async* {
    if (event is PricingRequested) {
      yield PricingInProgress();

      List<Item> itemsToPrice = event.itemsToPrice;
      List<Item> pricedItems = new List<Item>();

      try {
        List<PricedObject> currencyPrices =
            await pricingRepository.getPricesForCurrency();

        // TODO: O(n^2), epic please fix maybe use hash map
        // TODO: Give Chaos Orb value of 1
        currencyPrices.forEach((price) {
          itemsToPrice.forEach((item) {
            if (price.name.toLowerCase() == item.typeLine.toLowerCase()) {
              item.value = price.value;

              pricedItems.add(item);
            }
          });
        });

        if (pricedItems.length > 0) {
          yield PricingSuccess(pricedItems: pricedItems);
        } else {
          yield PricingFailure();
        }
      } catch (_) {
        print(_.toString()); //TODO REMOVE AND MAKE PART OF UI RESPONSE
        yield PricingFailure();
      }
    }
  }
}
