part of 'tab_bloc.dart';

abstract class TabState extends Equatable {
  const TabState();

  @override
  List<Object> get props => [];
}

// TODO: Remove this state? Is it really needed?
class TabInitial extends TabState {
  final StashTab stashTab;

  const TabInitial({@required this.stashTab}) : assert(stashTab != null);

  @override
  List<Object> get props => [stashTab];
}

class TabUpdated extends TabState {
  final StashTab stashTab;

  const TabUpdated({@required this.stashTab}) : assert(stashTab != null);

  @override
  List<Object> get props => [stashTab];
}
