import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:poe_currency/models/stash.dart';
import 'package:poe_currency/repositories/stash_repository.dart';

part 'stash_event.dart';
part 'stash_state.dart';

class StashBloc extends Bloc<StashEvent, StashState> {
  final StashRepository stashRepository;

  StashBloc({@required this.stashRepository})
      : assert(stashRepository != null),
        super(StashInitial());

  @override
  Stream<StashState> mapEventToState(
    StashEvent event,
  ) async* {
    if (event is StashRequested) {
      yield StashLoadInProgress();
      //try {
        final Stash stash =
            await stashRepository.getStash(event.accountName, event.sessionId);
        yield StashLoadSuccess(stash: stash);
      //} /*catch (_) {
        //yield StashLoadFailure(errorMessage: _.toString());
      //}*/
    }
    if (event is StashReset) {
      yield StashInitial();
    }
  }
}
