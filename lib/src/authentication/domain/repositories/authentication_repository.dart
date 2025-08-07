import 'package:dartz/dartz.dart';
import 'package:tdd_architecture/code/errors/failure.dart';
import 'package:tdd_architecture/code/utils/typedef.dart';
import 'package:tdd_architecture/src/authentication/domain/entities/user.dart';

abstract class AuthenticationRepository{
  const AuthenticationRepository();

  ResultVoid createUser({required String createdAt, required String name,required String avatar});

  ResultFuture<List<User>> getUsers();
}