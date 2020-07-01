import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'tab_event.dart';
part 'tab_state.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  final int numberOfTabs;

  TabBloc({@required this.numberOfTabs}) : assert(numberOfTabs != null);

  @override
  TabState get initialState => TabInitial();

  @override
  Stream<TabState> mapEventToState(
    TabEvent event,
  ) async* {
    if (event is TabNext) {
      int currentTabIndex = event.currentTabIndex;
      int newTabIndex = currentTabIndex < numberOfTabs - 1
          ? currentTabIndex + 1
          : currentTabIndex;

      yield TabUpdated(tabIndex: newTabIndex);
    }
    if (event is TabPrevious) {
      int currentTabIndex = event.currentTabIndex;
      int newTabIndex = currentTabIndex > 0
          ? currentTabIndex - 1
          : currentTabIndex;

      yield TabUpdated(tabIndex: newTabIndex);
    }
  }
}
