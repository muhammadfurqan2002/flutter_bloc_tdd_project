import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_architecture/code/errors/exceptions.dart';
import 'package:tdd_architecture/code/utils/constants.dart';
import 'package:tdd_architecture/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_architecture/src/authentication/data/models/user_model.dart';
class  MockClient extends Mock implements http.Client{}

void main(){
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;
  setUp((){
    client=MockClient();
    remoteDataSource=AuthenticationRemoteDataSourceImplementation(client);
    registerFallbackValue(Uri());
  });

  group('createUser', (){
    final createdAt='whatever.createdAt';
    final name='whatever.name';
    final avatar='whatever.avatar';

    test('should complete successfully when the status code is 200 or 201', ()async{
      when(()=>client.post(any(),body: any(named: 'body'))).thenAnswer((_)async=>http.Response('User created successfully',201));

      final methodCall=remoteDataSource.createUser;
      expect(methodCall(createdAt: createdAt, name: name, avatar: avatar),completes );
      verify(()=>client.post(Uri.https(kBaseUrl,kCreateUserEndpoint),body: jsonEncode({
        "createdAt": createdAt,
        "name": name,
        "avatar": avatar
      }))).called(1);
      verifyNoMoreInteractions(client);
    });
    test('should throw [ApiException] when the status code is not 200 or 201', () async {
      when(() => client.post(any(), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('Invalid email address', 400));

      final methodCall = remoteDataSource.createUser;

      await expectLater(
            () => methodCall(createdAt: createdAt, name: name, avatar: avatar),
        throwsA(
          isA<ApiException>()
              .having((e) => e.message, 'message', 'Invalid email address')
              .having((e) => e.statusCode, 'statusCode', 400),
        ),
      );

      verify(() => client.post(
        Uri.https(kBaseUrl,kCreateUserEndpoint),
        body: jsonEncode({
          "createdAt": createdAt,
          "name": name,
          "avatar": avatar,
        }),
      )).called(1);
      verifyNoMoreInteractions(client);
    });

  });
  group('getUsers', (){
    const tUsers=[UserModel.empty()];
    test('should return [List<User>] when the status code is 200', ()async{
        when(()=>client.get(any())).thenAnswer((_)async=>http.Response(jsonEncode([tUsers.first.toMap()]),200));

        final result=await remoteDataSource.getUsers();

        expect(result, equals(tUsers));
        verify(()=>client.get(Uri.https(kBaseUrl,kGetUserEndpoint))).called(1);
        verifyNoMoreInteractions(client);
    });
    test('should throw [ApiException] when the status code is not 200', () async {
      final tMessage="Server down, Server down, I repeat Server down. Mayday Mayday Mayday, We are going down.";
      when(()=>client.get(any())).thenAnswer((_)async=>http.Response('Server down, Server down, I repeat Server down. Mayday Mayday Mayday, We are going down.', 500));

      final methodCall=remoteDataSource.getUsers;
      expect(()=>methodCall(),throwsA(ApiException(message: tMessage, statusCode: 500)));
      verify(()=>client.get(Uri.https(kBaseUrl,kGetUserEndpoint))).called(1);
      verifyNoMoreInteractions(client);
    });
  });

}