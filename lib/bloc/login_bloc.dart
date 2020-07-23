import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:equatable/equatable.dart';
import 'package:poe_currency/models/item.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final List<Item> allItems;

  LoginBloc({@required this.allItems})
      : assert(allItems != null),
        super(LoginInitial());

  // Avoid spamming bloc when typing
  @override
  Stream<Transition<LoginEvent, LoginState>> transformEvents(
    Stream<LoginEvent> events,
    TransitionFunction<LoginEvent, LoginState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 200)),
      transitionFn,
    );
  }

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginSearchRequested) {
      List<Item> results;
      String searchString = event.searchString.toLowerCase();

      yield LoginInProgress();
      results = allItems
          .where((item) =>
              item.typeLine.toLowerCase().contains(searchString) ||
              item.name.toLowerCase().contains(searchString) ||
              (searchString == '6-link' && item.socketLinks == 6))
          .toList();

      if (results.isNotEmpty) {
        yield LoginSuccess(loginResult: results);
      } else {
        yield LoginFailure();
      }
    }
    if (event is LoginRequested) {
      List<Item> results = new List<Item>.from(allItems);
      LoginType loginType = event.loginType;

      yield LoginInProgress();
      if (loginType == LoginType.MOST_EXPENSIVE) {
        results.sort((a, b) => b.totalValue.compareTo(a.totalValue));
      }

      if (results.isNotEmpty) {
        yield LoginSuccess(loginResult: results);
      } else {
        yield LoginFailure();
      }
    }
  }
}
