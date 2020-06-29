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

  const StashLoadSuccess({@required this.items}) : assert(items != null);

  @override
  List<Object> get props => [items];
}

class StashLoadFailure extends StashState {}
