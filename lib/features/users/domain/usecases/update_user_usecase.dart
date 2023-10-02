import 'package:crud/features/users/domain/entities/user.dart';
import 'package:crud/features/users/domain/repositories/user_repository.dart';

class UpdateUserUsecase {
  final UserRepository userRepository;

  UpdateUserUsecase(this.userRepository);

  Future<void> execute(User user) async {
    return await userRepository.updateUser(user);
  }
}
