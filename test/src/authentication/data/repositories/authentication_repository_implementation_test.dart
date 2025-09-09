import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_architecture/core/errors/exceptions.dart';
import 'package:tdd_architecture/core/errors/failure.dart';
import 'package:tdd_architecture/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_architecture/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:tdd_architecture/src/authentication/domain/entities/user.dart';

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

    final createdAt='whatever.createdAt';
    final name='whatever.name';
    final avtar='whatever.avatar';

    test("should call the [RemoteDataSource.createUser] and complete successfully when call to the remote source is successful", ()async{
      //ARRANGE
      when(()=>remoteDataSource.createUser(createdAt: any(named: 'createdAt'), name: any(named: 'name'), avatar: any(named: 'avatar'))).thenAnswer((_)async=>Future.value());


      //ACT

      final result=await repoImpl.createUser(createdAt: createdAt, name: name, avatar: avtar);

      expect(result, equals(const Right(null)));

      verify(()=>remoteDataSource.createUser(createdAt: createdAt, name: name, avatar: avtar)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test("should return a [ApiFailure] when the call to the remote source is unsuccessful", ()async{
      when(()=>remoteDataSource.createUser(createdAt: any(named: 'createdAt'), name: any(named: 'name'), avatar: any(named: 'avatar'))).thenThrow(ApiException(message: 'Unknown Error Occured', statusCode: 500));
      final result=await repoImpl.createUser(createdAt: createdAt, name: name, avatar: avtar);
      expect(result, equals(Left(ApiFailure(message: 'Unknown Error Occured',statusCode: 500))));
      verify(()=>remoteDataSource.createUser(createdAt: createdAt, name: name, avatar: avtar)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });



  group("getUsers", (){
    test("Should call the [RemoteDataSource.getUsers] and return [List<Users>] when call to remote source is successful",()async{

      when(()=>remoteDataSource.getUsers()).thenAnswer((_) async =>[]);

      final result=await repoImpl.getUsers();
      expect(result, isA<Right<dynamic,List<User>>>());
      verify(()=>remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    final tException=ApiException(message: 'Unknown Error Occured',statusCode: 500);

    test("should return a [ApiFailure] when the call to the remote source is unsuccessful", ()async{
      when(()=>remoteDataSource.getUsers()).thenThrow(ApiException(message: 'Unknown Error Occured', statusCode: 500));
      final result=await repoImpl.getUsers();
      expect(result, equals(Left(ApiFailure.fromException(tException))));
      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });

}