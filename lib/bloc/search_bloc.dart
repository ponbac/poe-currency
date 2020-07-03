import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:equatable/equatable.dart';
import 'package:poe_currency/models/item.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final List<Item> allItems;

  SearchBloc({@required this.allItems}) : assert(allItems != null);

  @override
  SearchState get initialState => SearchInitial();

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchRequested) {
      List<Item> results;

      yield SearchInProgress();
      results = allItems
          .where((item) => item.typeLine
              .toLowerCase()
              .contains(event.searchString.toLowerCase()))
          .toList();

      if (results.isNotEmpty) {
        yield SearchSuccess(searchResult: results);
      } else {
        yield SearchFailure();
      }
    }
  }
}
