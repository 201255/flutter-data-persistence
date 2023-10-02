import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:crud/features/users/domain/entities/user.dart';
import 'package:crud/features/users/domain/usecases/get_users_usecase.dart';
import 'package:crud/features/users/domain/usecases/delete_user_usecase.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetUsersUsecase getUsersUsecase;
  final DeleteUserUsecase deleteUserUsecase;

  UsersBloc({required this.getUsersUsecase, required this.deleteUserUsecase}) : super(UsersInitial()) {
    on<UsersEvent>((event, emit) async {
      // print("se esta ejecutando el evento users blocs");
      if(event is GetUsers) {
        try {
          emit(GettingUsers());
          List<User> users = await getUsersUsecase.execute();
          emit(UserTable(users: users));
        } catch (e) {
          emit(ErrorGettingUsers(message: e.toString()));
        }
      } else if(event is PressDeleteUserButton) {
        try {
          emit(DeletingUser());
          await deleteUserUsecase.execute(event.id);
          emit(UserDeleted());
        } catch (e) {
          emit(ErrorDeletingUser(message: e.toString()));
        }
      }
    });
  }
}
