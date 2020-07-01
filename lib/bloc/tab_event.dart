part of 'tab_bloc.dart';

abstract class TabEvent extends Equatable {
  const TabEvent();
}

class TabNext extends TabEvent {
  final int currentTabIndex;

  const TabNext({@required this.currentTabIndex})
      : assert(currentTabIndex != null);

  @override
  List<Object> get props => [currentTabIndex];
}

class TabPrevious extends TabEvent {
  final int currentTabIndex;

  const TabPrevious({@required this.currentTabIndex})
      : assert(currentTabIndex != null);

  @override
  List<Object> get props => [currentTabIndex];
}
