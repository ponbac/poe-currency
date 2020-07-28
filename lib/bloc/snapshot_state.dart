part of 'snapshot_bloc.dart';

abstract class SnapshotState extends Equatable {
  const SnapshotState();
}

class SnapshotInitial extends SnapshotState {
  @override
  List<Object> get props => [];
}
