part of 'stash_bloc.dart';

abstract class StashState extends Equatable {
  const StashState();

  @override
  List<Object> get props => [];
}

class StashInitial extends StashState {}

class StashLoadInProgress extends StashState {}

class StashLoadSuccess extends StashState {
  final StashTab stashTab;

  const StashLoadSuccess({@required this.stashTab})
      : assert(stashTab != null);

  @override
  List<Object> get props => [stashTab];
}

class StashLoadFailure extends StashState {
  final String errorMessage;

  const StashLoadFailure({@required this.errorMessage}) : assert(errorMessage != null);

  @override
  List<Object> get props => [errorMessage];
}
