import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:crud/features/users/domain/entities/user.dart';
import 'package:crud/features/users/domain/usecases/create_user_usecase.dart';
import 'package:crud/features/users/domain/usecases/update_user_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final CreateUserUsecase createUserUsecase;
  final UpdateUserUsecase updateUserUsecase;

  UserBloc({required this.createUserUsecase, required this.updateUserUsecase}) : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if(event is PressCreateUserButton) {
        try {
          emit(SavingUser());
          await createUserUsecase.execute(event.user);
          emit(UserSaved());
        } catch (e) {
          emit(ErrorSavingUser(message: e.toString()));
        }
      } else if(event is PressUpdateUserButton) {
        try {
          emit(SavingUser());
          await updateUserUsecase.execute(event.user);
          emit(UserSaved());
        } catch (e) {
          emit(ErrorSavingUser(message: e.toString()));
        }
      }
    });
  }
}
