part of 'users_bloc.dart';

@immutable
abstract class UsersEvent {}

class GetUsers extends UsersEvent {}

class PressDeleteUserButton extends UsersEvent {
  final String id;

  PressDeleteUserButton({required this.id});
}
