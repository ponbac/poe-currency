part of 'friends_bloc.dart';

abstract class FriendsState extends Equatable {
  const FriendsState();

  @override
  List<Object> get props => [];
}

class FriendsInitial extends FriendsState {}

class FriendsInProgress extends FriendsState {}

class AddFriendSuccess extends FriendsState {}

class AddFriendFailure extends FriendsState {
  final String errorMessage;

  const AddFriendFailure({@required this.errorMessage})
      : assert(errorMessage != null);

  @override
  List<Object> get props => [errorMessage];
}
