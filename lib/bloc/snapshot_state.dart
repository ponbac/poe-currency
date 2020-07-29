part of 'snapshot_bloc.dart';

abstract class SnapshotState extends Equatable {
  const SnapshotState();

  @override
  List<Object> get props => [];
}

class SnapshotInitial extends SnapshotState {}

class SnapshotLoadInProgress extends SnapshotState {}

class SnapshotLoadSuccess extends SnapshotState {
  final Snapshot snapshot;

  const SnapshotLoadSuccess({@required this.snapshot})
      : assert(snapshot != null);

  @override
  List<Object> get props => [snapshot];
}

class SnapshotListLoadSuccess extends SnapshotState {
  final List<Snapshot> snapshots;

  const SnapshotListLoadSuccess({@required this.snapshots})
      : assert(snapshots != null);

  @override
  List<Object> get props => [snapshots];
}

class SnapshotLoadFailure extends SnapshotState {
  final String errorMessage;

  const SnapshotLoadFailure({@required this.errorMessage}) : assert(errorMessage != null);

  @override
  List<Object> get props => [errorMessage];
}

