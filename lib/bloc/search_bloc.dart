import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:equatable/equatable.dart';
import 'package:poe_currency/models/item.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final List<Item> allItems;

  SearchBloc({@required this.allItems}) : assert(allItems != null), super(SearchInitial());

  // Avoid spamming bloc when typing
  @override
  Stream<Transition<SearchEvent, SearchState>> transformEvents(
    Stream<SearchEvent> events,
    TransitionFunction<SearchEvent, SearchState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchRequested) {
      List<Item> results;
      String searchString = event.searchString.toLowerCase();

      yield SearchInProgress();
      results = allItems
          .where((item) => item.typeLine
              .toLowerCase()
              .contains(searchString.toLowerCase()))
          .toList();

      if (results.isNotEmpty) {
        yield SearchSuccess(searchResult: results);
      } else {
        yield SearchFailure();
      }
    }
  }
}
