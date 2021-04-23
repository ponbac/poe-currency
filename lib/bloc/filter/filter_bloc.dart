import 'dart:async';
import 'package:poe_currency/bloc/pricing/pricing_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:equatable/equatable.dart';
import 'package:poe_currency/models/item.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final List<Item> allItems;

  final PricingBloc pricingBloc;
  StreamSubscription pricingBlocSubscription;

  FilterBloc({@required this.allItems, @required this.pricingBloc})
      : assert(allItems != null),
        assert(pricingBloc != null),
        super(FilterInitial()) {
    // TODO: Solve this in a better way? https://github.com/felangel/bloc/issues/1512
    if (pricingBloc.state is PricingSuccess) {
      this.add(FilterRequested(filterType: FilterType.MOST_EXPENSIVE));
    }

    pricingBlocSubscription = pricingBloc.listen((state) {
      if (state is PricingSuccess) {
        this.add(FilterRequested(filterType: FilterType.MOST_EXPENSIVE));
      }
    });
  }

  // Avoid spamming bloc when typing
  @override
  Stream<Transition<FilterEvent, FilterState>> transformEvents(
    Stream<FilterEvent> events,
    TransitionFunction<FilterEvent, FilterState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 200)),
      transitionFn,
    );
  }

  @override
  Stream<FilterState> mapEventToState(
    FilterEvent event,
  ) async* {
    if (event is FilterSearchRequested) {
      List<Item> results;
      String searchString = event.searchString.toLowerCase();

      yield FilterInProgress();
      results = allItems
          .where((item) =>
              item.typeLine.toLowerCase().contains(searchString) ||
              item.name.toLowerCase().contains(searchString) ||
              (searchString == '6-link' && item.socketLinks == 6))
          .toList();

      if (results.isNotEmpty) {
        this.add(FilterRequested(filterType: FilterType.MOST_EXPENSIVE, itemsToFilter: results));
      } else {
        yield FilterFailure();
      }
    }
    if (event is FilterRequested) {
      List<Item> results = event.itemsToFilter ??
          new List<Item>.from(
              allItems); // TODO: Should I ever filter all items? Do I need to store them here, maybe pass items to filter every time?
      FilterType filterType = event.filterType;

      yield FilterInProgress();
      if (filterType == FilterType.MOST_EXPENSIVE) {
        results.sort((a, b) => b.totalValue.compareTo(a.totalValue));
      }

      if (results.isNotEmpty) {
        yield FilterSuccess(filterResult: results);
      } else {
        yield FilterFailure();
      }
    }
  }

  @override
  Future<void> close() {
    pricingBlocSubscription.cancel();
    return super.close();
  }
}
