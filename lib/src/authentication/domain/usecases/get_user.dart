import 'package:tdd_architecture/core/usecase/usecase.dart';
import 'package:tdd_architecture/core/utils/typedef.dart';
import 'package:tdd_architecture/src/authentication/domain/entities/user.dart';
import 'package:tdd_architecture/src/authentication/domain/repositories/authentication_repository.dart';

class GetUsers extends UsecaseWithoutParams<List<User>>{
  final AuthenticationRepository _repository;

  GetUsers({required AuthenticationRepository repository}) : _repository = repository;

  @override
  ResultFuture<List<User>> call() async =>_repository.getUsers();
}


