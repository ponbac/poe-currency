part of 'login_bloc.dart';


abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginSuccess extends LoginState {
  final List<Item> loginResult;

  const LoginSuccess({@required this.loginResult}) : assert(loginResult != null);

  @override
  List<Object> get props => [loginResult];
}

class LoginFailure extends LoginState {}