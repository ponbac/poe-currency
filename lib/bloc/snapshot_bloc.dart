import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'snapshot_event.dart';
part 'snapshot_state.dart';

class SnapshotBloc extends Bloc<SnapshotEvent, SnapshotState> {
  SnapshotBloc() : super(SnapshotInitial());

  @override
  Stream<SnapshotState> mapEventToState(
    SnapshotEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
