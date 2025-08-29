// here we just only single value here can be failure or success means data or error
// here we return Model version of data
// data source always return model version of data

import 'package:tdd_architecture/src/authentication/data/models/user_model.dart';

abstract class AuthenticationRemoteDataSource{
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });
  Future<List<UserModel>> getUsers();
}