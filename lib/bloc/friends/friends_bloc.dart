import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:poe_currency/repositories/user_repository.dart';

part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  final UserRepository userRepository;

  FriendsBloc({@required this.userRepository}) : super(FriendsInitial());

  @override
  Stream<FriendsState> mapEventToState(
    FriendsEvent event,
  ) async* {
    if (event is AddFriendRequested) {
      yield FriendsInProgress();

      try {
        var responseUser =
            await userRepository.addFriend(userToAdd: event.usernameToAdd);
        if (responseUser == null) {
          yield AddFriendFailure(errorMessage: 'Could not add friend!');
        } else {
          yield AddFriendSuccess();
        }
      } catch (_) {
        yield AddFriendFailure(errorMessage: _.toString());
      }
    }
  }
}
