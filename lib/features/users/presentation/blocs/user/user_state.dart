part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class SavingUser extends UserState {}
class UserSaved extends UserState {}
class ErrorSavingUser extends UserState {
  final String message;

  ErrorSavingUser({required this.message});
}
