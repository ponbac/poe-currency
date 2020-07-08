import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:equatable/equatable.dart';
import 'package:poe_currency/models/item.dart';
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
        HashMap<String, double> pricesMap =
            await pricingRepository.getPricesForCurrency();

        itemsToPrice.forEach((item) {
          item.value = pricesMap[item.typeLine];

          if (item.value == null) {
            item.value = pricesMap[item.name] ?? 0.0;
          }

          pricedItems.add(item);
        });

        yield PricingSuccess(pricedItems: pricedItems);
      } catch (_) {
        print(_.toString()); //TODO REMOVE AND MAKE PART OF UI RESPONSE
        yield PricingFailure();
      }
    }
  }
}
