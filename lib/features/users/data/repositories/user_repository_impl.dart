import 'package:crud/features/users/data/datasources/user_local_data_source.dart';
import 'package:crud/features/users/domain/entities/user.dart';
import 'package:crud/features/users/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource userLocalDataSource;

  UserRepositoryImpl({required this.userLocalDataSource});

  @override
  Future<List<User>> getUsers() async {
    return await userLocalDataSource.getUsers();
  }

  @override
  Future<void> createUser(User user) async {
    return await userLocalDataSource.createUser(user);
  }

  @override
  Future<void> updateUser(User user) async {
    return await userLocalDataSource.updateUser(user);
  }

  @override
  Future<void> deleteUser(String id) async {
    return await userLocalDataSource.deleteUser(id);
  }
}