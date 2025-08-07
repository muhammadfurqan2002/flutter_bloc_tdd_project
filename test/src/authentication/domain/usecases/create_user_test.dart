// what does the class depend on which repository
// Answer -- AuthRepository
//how can we create a fake version of the dependency
// Answer -- mocktail
// how do we control what our dependencies do
// Answer -- Using the Mocktail Api`s



import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_architecture/code/errors/failure.dart';
import 'package:tdd_architecture/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_architecture/src/authentication/domain/usecases/create_user.dart';

import 'authentication_repository.mock.dart';



void main(){
  late CreateUser usecase;
  late AuthenticationRepository _repository;
  final params=CreateUserParams.empty();
  setUp((){
    _repository=MockAuthRepo();
    usecase=CreateUser(_repository);
  });
  test("should call the [AuthRepo.createUser]",() async {
  //   Arrange
  //   STUB
    when(()=>_repository.createUser(createdAt: any(named: "createdAt"),name: any(named: "name"),avatar: any(named: "avatar"))).thenAnswer((_)async =>
    const Right(null));

  //   Act
    final result=await usecase(params);
  //   Assert
    expect(result, equals(Right<dynamic,void>(null)));
    verify(()=>_repository.createUser(createdAt: params.createdAt, name: params.name, avatar: params.avatar)).called(1);

    verifyNoMoreInteractions(_repository);
  });
}
