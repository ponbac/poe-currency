import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:poe_currency/models/nav_page.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavPage> {
  NavigationBloc() : super(NavPage.LOGIN);

  @override
  Stream<NavPage> mapEventToState(NavigationEvent event) async* {
    if (event is PageRequested) {
      yield event.page;
    }
  }
}
