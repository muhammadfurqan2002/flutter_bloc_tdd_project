import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_architecture/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_architecture/src/authentication/data/repositories/authentication_repository_implementation.dart';

class MockAuthRemoteDataSource extends Mock implements AuthenticationRemoteDataSource {}


void main(){
  late MockAuthRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImplementation repoImpl;
  setUp((){
  remoteDataSource=MockAuthRemoteDataSource();
    repoImpl=AuthenticationRepositoryImplementation(remoteDataSource);
  });

  //function name
  group('createUser', (){
    test("should call the [RemoteDataSource.createUser] and complete successfully when call to the remote source is successful", ()async{
      //ARRANGE
      when(()=>remoteDataSource.createUser(createdAt: any(named: 'createdAt'), name: any(named: 'name'), avatar: any(named: 'avatar'))).thenAnswer((_)async=>Future.value());

      final createdAt='whatever.createdAt';
      final name='whatever.name';
      final avtar='whatever.avatar';

      //ACT

      final result=repoImpl.createUser(createdAt: createdAt, name: name, avatar: avtar);

      expect(result, equals(const Right(null)));

      verify(()=>remoteDataSource.createUser(createdAt: createdAt, name: name, avatar: avtar)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}