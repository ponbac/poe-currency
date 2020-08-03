part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

class StashSelected extends NavigationState {}

class CharacterSelected extends NavigationState {}

class SettingsSelected extends NavigationState {}