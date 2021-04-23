part of 'stash_bloc.dart';

abstract class StashState extends Equatable {
  const StashState();

  @override
  List<Object> get props => [];
}

class StashInitial extends StashState {}

class StashLoadInProgress extends StashState {}

class StashLoadSuccess extends StashState {
  final Stash stash;

  const StashLoadSuccess({@required this.stash})
      : assert(stash != null);

  @override
  List<Object> get props => [stash];
}

class StashLoadFailure extends StashState {
  final String errorMessage;

  const StashLoadFailure({@required this.errorMessage}) : assert(errorMessage != null);

  @override
  List<Object> get props => [errorMessage];
}
