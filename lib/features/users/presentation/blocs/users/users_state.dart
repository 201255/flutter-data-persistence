part of 'users_bloc.dart';

@immutable
abstract class UsersState {}

class UsersInitial extends UsersState {}

class GettingUsers extends UsersState {}
class UserTable extends UsersState {
  final List<User> users;

  UserTable({required this.users});
}
class ErrorGettingUsers extends UsersState {
  final String message;

  ErrorGettingUsers({required this.message});
}

class DeletingUser extends UsersState {}
class UserDeleted extends UsersState {}
class ErrorDeletingUser extends UsersState {
  final String message;

  ErrorDeletingUser({required this.message});
}
