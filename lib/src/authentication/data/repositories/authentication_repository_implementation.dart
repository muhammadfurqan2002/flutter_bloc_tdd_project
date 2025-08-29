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
    throw UnimplementedError();
  }

  @override
  ResultFuture<List<User>> getUsers() async{
    // TODO: implement getUsers
    throw UnimplementedError();
  }

}