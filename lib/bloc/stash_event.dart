part of 'stash_bloc.dart';

abstract class StashEvent extends Equatable {
  const StashEvent();
}

class StashRequested extends StashEvent {
  final String sessionId;
  final String accountName;

  const StashRequested({@required this.sessionId, @required this.accountName})
      : assert(sessionId != null && accountName != null);

  @override
  List<Object> get props => [sessionId, accountName];
}
