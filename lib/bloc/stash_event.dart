part of 'stash_bloc.dart';

abstract class StashEvent extends Equatable {
  const StashEvent();
}

class StashRequested extends StashEvent {
  final String username;
  final String sessionId;
  final String accountName;

  const StashRequested(
      {@required this.username,
      @required this.sessionId,
      @required this.accountName})
      : assert(username != null && sessionId != null && accountName != null);

  @override
  List<Object> get props => [username, sessionId, accountName];
}

class StashReset extends StashEvent {
  @override
  List<Object> get props => [];
}
