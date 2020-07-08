import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:equatable/equatable.dart';
import 'package:poe_currency/models/item.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final List<Item> allItems;

  FilterBloc({@required this.allItems})
      : assert(allItems != null),
        super(FilterInitial());

  // Avoid spamming bloc when typing
  @override
  Stream<Transition<FilterEvent, FilterState>> transformEvents(
    Stream<FilterEvent> events,
    TransitionFunction<FilterEvent, FilterState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 300)),
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
        yield FilterSuccess(filterResult: results);
      } else {
        yield FilterFailure();
      }
    }
    if (event is FilterRequested) {
      List<Item> results = new List<Item>.from(allItems);
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
}
