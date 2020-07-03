import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:poe_currency/models/item.dart';
import 'package:poe_currency/models/stash.dart';
import 'package:poe_currency/models/stash_tab.dart';

part 'tab_event.dart';
part 'tab_state.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  static const _INITIAL_TAB_INDEX = 0;
  
  final Stash stash;

  TabBloc({@required this.stash}) : assert(stash != null), super(TabInitial(stashTab: stash.tabs[_INITIAL_TAB_INDEX]));

  @override
  Stream<TabState> mapEventToState(
    TabEvent event,
  ) async* {
    if (event is TabNext) {
      int currentTabIndex = event.currentTabIndex;
      int newTabIndex = currentTabIndex < stash.tabs.length - 1
          ? currentTabIndex + 1
          : currentTabIndex;

      yield TabUpdated(stashTab: stash.tabs[newTabIndex]);
    }
    if (event is TabPrevious) {
      int currentTabIndex = event.currentTabIndex;
      int newTabIndex =
          currentTabIndex > 0 ? currentTabIndex - 1 : currentTabIndex;

      yield TabUpdated(stashTab: stash.tabs[newTabIndex]);
    }
    if (event is CustomTabRequested) {
      StashTab customTab = new StashTab(name: event.tabName, items: event.items);

      yield TabUpdated(stashTab: customTab);
    }
  }
}
