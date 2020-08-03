import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:poe_currency/models/user/snapshot.dart';
import 'package:poe_currency/repositories/pricing_repository.dart';

part 'snapshot_event.dart';
part 'snapshot_state.dart';

class SnapshotBloc extends Bloc<SnapshotEvent, SnapshotState> {
  final PricingRepository pricingRepository;

  SnapshotBloc({@required this.pricingRepository})
      : assert(pricingRepository != null),
        super(SnapshotInitial());

  @override
  Stream<SnapshotState> mapEventToState(
    SnapshotEvent event,
  ) async* {
    if (event is LatestSnapshotRequested) {
      yield SnapshotLoadInProgress();

      try {
        if (event.userList == null) {
          final Snapshot snapshot =
              await pricingRepository.getLatestSnapshot(event.username);
          yield SnapshotLoadSuccess(snapshot: snapshot);
        } else if (event.username == null) {
          final List<Snapshot> snapshots = await pricingRepository
              .getLatestSnapshotsFromList(event.userList);
          yield SnapshotListLoadSuccess(snapshots: snapshots);
        }
      } catch (_) {
        yield SnapshotLoadFailure(errorMessage: _.toString());
      }
    }
  }
}
