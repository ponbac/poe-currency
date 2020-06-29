import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:poe_currency/models/item.dart';
import 'package:poe_currency/repositories/stash_api_client.dart';

part 'stash_event.dart';
part 'stash_state.dart';

class StashBloc extends Bloc<StashEvent, StashState> {
  final StashApiClient stashApiClient;

  StashBloc({@required this.stashApiClient}) : assert(stashApiClient != null);

  @override
  StashState get initialState => StashInitial();

  @override
  Stream<StashState> mapEventToState(
    StashEvent event,
  ) async* {
    if (event is StashRequested) {
      yield StashLoadInProgress();
      try {
        int stashIndex = event.stashIndex ?? 0;

        final List<Item> items = await stashApiClient.getStashTab(
            event.accountName, event.sessionId, stashIndex);
        yield StashLoadSuccess(items: items, stashIndex: stashIndex);
      } catch (_) {
        yield StashLoadFailure();
      }
    }
  }
}
