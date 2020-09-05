part of 'friends_bloc.dart';

abstract class FriendsEvent extends Equatable {
  const FriendsEvent();
}

class AddFriendRequested extends FriendsEvent {
  final String usernameToAdd;

  const AddFriendRequested({@required this.usernameToAdd})
      : assert(usernameToAdd != null);

  @override
  List<Object> get props => [usernameToAdd];
}

class ResetFriends extends FriendsEvent {
  @override
  List<Object> get props => [];
}