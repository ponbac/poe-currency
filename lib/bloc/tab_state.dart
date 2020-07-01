part of 'tab_bloc.dart';

abstract class TabState extends Equatable {
  const TabState();

  @override
  List<Object> get props => [];
}

class TabInitial extends TabState {}

class TabUpdated extends TabState {
  final int tabIndex;

  const TabUpdated({@required this.tabIndex}) : assert(tabIndex != null);

  @override
  List<Object> get props => [tabIndex];
}
