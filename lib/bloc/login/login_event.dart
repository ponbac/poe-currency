part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginRequested extends LoginEvent {
  final String username;
  final String password;

  const LoginRequested({@required this.username, @required this.password})
      : assert(username != null),
        assert(password != null);

  @override
  List<Object> get props => [username, password];
}

class SignUpRequested extends LoginEvent {
  final String username;
  final String password;
  final String accountname;
  final String poesessid;

  const SignUpRequested({@required this.username, @required this.password, @required this.accountname, @required this.poesessid})
      : assert(username != null),
        assert(password != null),
        assert(accountname != null),
        assert(poesessid != null);

  @override
  List<Object> get props => [username, password, accountname, poesessid];
}

class LoginWithTokenRequested extends LoginEvent {
  @override
  List<Object> get props => [];
}

class LogoutRequested extends LoginEvent {
  @override
  List<Object> get props => [];
}