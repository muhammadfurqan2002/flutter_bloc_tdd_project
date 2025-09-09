import 'package:dartz/dartz.dart';
import 'package:tdd_architecture/core/errors/failure.dart';
import 'package:tdd_architecture/core/utils/typedef.dart';
import 'package:tdd_architecture/src/authentication/domain/entities/user.dart';

abstract class AuthenticationRepository{
  const AuthenticationRepository();

  // Either<Exception,void> left side is error and right is success but we not here deal with error we create custom Failure class or type
  // Future<Either<Failure,void>> createUser({required String createdAt, required String name,required String avatar});
  // Future<(Exception,void)> createUser({required String createdAt, required String name,required String avatar});
  ResultVoid createUser({required String createdAt, required String name,required String avatar});

  // Future<Either<Failure,List<User>> getUsers(); // instead of rewriting this again and again we use dartz package
  ResultFuture<List<User>> getUsers();
}