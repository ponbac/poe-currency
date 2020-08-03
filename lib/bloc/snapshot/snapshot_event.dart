part of 'snapshot_bloc.dart';

abstract class SnapshotEvent extends Equatable {
  const SnapshotEvent();
}

class LatestSnapshotRequested extends SnapshotEvent {
  final String username;
  final List<String> userList;

  const LatestSnapshotRequested({this.username, this.userList})
      : assert((username != null && userList == null) || (username == null && userList != null));

  @override
  List<Object> get props => [username, userList];
}