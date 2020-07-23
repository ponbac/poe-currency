import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:equatable/equatable.dart';
import 'package:poe_currency/models/user.dart';
import 'package:poe_currency/repositories/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;

  LoginBloc({@required this.userRepository})
      : assert(userRepository != null),
        super(LoginInitial()) {
    this.add(LoginWithTokenRequested());
  }

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginRequested) {
      yield LoginInProgress();

      var token = await userRepository.authenticate(
          username: event.username, password: event.password);

      if (token == null) {
        yield LoginFailure();
      } else {
        await userRepository.persistToken(token);
        yield LoginSuccess(user: await userRepository.fetchCurrentUser());
      }
    }
    if (event is LoginWithTokenRequested) {
      if (await userRepository.hasToken()) {
        yield LoginInProgress();
        User user = await userRepository.fetchCurrentUser();

        if (user == null) {
          yield LoginFailure();
        } else {
          yield LoginSuccess(user: user);
        }
      } else {
        yield LoginInitial();
      }
    }
    if (event is LogoutRequested) {
      await userRepository.deleteToken();
      yield LoginInitial();
    }
  }
}
