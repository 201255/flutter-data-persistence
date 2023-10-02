part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class PressCreateUserButton extends UserEvent {
  final User user;

  PressCreateUserButton({required this.user});
}

class PressUpdateUserButton extends UserEvent {
  final User user;

  PressUpdateUserButton({required this.user});
}
