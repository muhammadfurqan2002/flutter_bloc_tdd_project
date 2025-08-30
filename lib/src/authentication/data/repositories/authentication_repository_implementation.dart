import 'package:dartz/dartz.dart';
import 'package:tdd_architecture/code/errors/exceptions.dart';
import 'package:tdd_architecture/code/errors/failure.dart';
import 'package:tdd_architecture/code/utils/typedef.dart';
import 'package:tdd_architecture/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_architecture/src/authentication/domain/entities/user.dart';
import 'package:tdd_architecture/src/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImplementation implements AuthenticationRepository{

  const AuthenticationRepositoryImplementation(this.remoteDataSource);

  final AuthenticationRemoteDataSource remoteDataSource;

  @override
  ResultVoid createUser({required String createdAt, required String name, required String avatar})async {
    // TODO: implement createUser
    try{
      await remoteDataSource.createUser(createdAt: createdAt, name: name, avatar: avatar);
      return  Right(null); // when our function return void we always return Right(null)
    }on ApiException catch(e){
      // return Left(ApiFailure(message: e.message, statusCode: e.statusCode));
      return Left(ApiFailure.fromException(e));
    }

  }

  @override
  ResultFuture<List<User>> getUsers() async{
    // TODO: implement getUsers
    try{

      final result=await remoteDataSource.getUsers();
      return Right(result);
    }on ApiException catch(e){
      return Left(ApiFailure.fromException(e));
    }
  }

}