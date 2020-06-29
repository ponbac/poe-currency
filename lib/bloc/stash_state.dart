part of 'stash_bloc.dart';

abstract class StashState extends Equatable {
  const StashState();

  @override
  List<Object> get props => [];
}

class StashInitial extends StashState {}

class StashLoadInProgress extends StashState {}

class StashLoadSuccess extends StashState {
  final List<Item> items;
  final int stashIndex;

  const StashLoadSuccess({@required this.items, @required this.stashIndex})
      : assert(items != null && stashIndex != null);

  @override
  List<Object> get props => [items, stashIndex];
}

class StashLoadFailure extends StashState {}
