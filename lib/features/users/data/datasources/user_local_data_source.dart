import 'dart:convert';

import 'package:crud/features/users/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:crud/features/users/data/models/user_model.dart';

abstract class UserLocalDataSource {
  Future<List<UserModel>> getUsers();
  Future<void> createUser(User user);
  Future<void> updateUser(User user);
  Future<void> deleteUser(String id);
}

class UserLocalDataSourceImp implements UserLocalDataSource {
  @override
  Future<List<UserModel>> getUsers() async {
    await Future.delayed(const Duration(seconds: 2));
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String usersString = sharedPreferences.getString('users') ?? "[]";
    List<UserModel> users = jsonDecode(usersString).map<UserModel>((data) => UserModel.fromJson(data)).toList();

    return users;
  }

  @override
  Future<void> createUser(User user) async {
    await Future.delayed(const Duration(seconds: 2));
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String usersString = sharedPreferences.getString('users') ?? "[]";
    List<UserModel> users = jsonDecode(usersString).map<UserModel>((data) => UserModel.fromJson(data)).toList();

    users.add(UserModel.fromEntity(user));
    sharedPreferences.setString('users', jsonEncode(users));
  }

  @override
  Future<void> updateUser(User user) async {
    await Future.delayed(const Duration(seconds: 2));
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String usersString = sharedPreferences.getString('users') ?? "[]";
    List<UserModel> users = jsonDecode(usersString).map<UserModel>((data) => UserModel.fromJson(data)).toList();

    users.removeWhere((item) => item.id == user.id);
    users.add(UserModel.fromEntity(user));
    sharedPreferences.setString('users', jsonEncode(users));
  }

  @override
  Future<void> deleteUser(String id) async {
    await Future.delayed(const Duration(seconds: 2));
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String usersString = sharedPreferences.getString('users') ?? "[]";
    List<UserModel> users = jsonDecode(usersString).map<UserModel>((data) => UserModel.fromJson(data)).toList();

    users.removeWhere((item) => item.id == id);
    sharedPreferences.setString('users', jsonEncode(users));
  }
}