part of 'login_bloc.dart';

enum LoginType { MOST_EXPENSIVE }

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginSearchRequested extends LoginEvent {
  final String searchString;

  const LoginSearchRequested({@required this.searchString})
      : assert(searchString != null);

  @override
  List<Object> get props => [searchString];
}

class LoginRequested extends LoginEvent {
  final LoginType loginType;

  const LoginRequested({@required this.loginType})
      : assert(loginType != null);

  List<Object> get props => [loginType];
}
