part of 'login_bloc.dart';


abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginSuccess extends LoginState {
  final User user;

  const LoginSuccess({@required this.user}) : assert(user != null);

  @override
  List<Object> get props => [user];
}

class SignUpSuccess extends LoginState {
  final User user;

  const SignUpSuccess({@required this.user}) : assert(user != null);

  @override
  List<Object> get props => [user];
}

class LoginFailure extends LoginState {}