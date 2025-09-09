// here we just only single value here can be failure or success means data or error
// here we return Model version of data
// data source always return model version of data

import 'dart:convert';

import 'package:tdd_architecture/core/errors/exceptions.dart';
import 'package:tdd_architecture/core/utils/typedef.dart';
import 'package:tdd_architecture/src/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/utils/constants.dart';

abstract class AuthenticationRemoteDataSource{
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });
  Future<List<UserModel>> getUsers();
}

const kCreateUserEndpoint='/test-api//users';
const kGetUserEndpoint='/test-api/users';


// here we test this one Data Source


class AuthenticationRemoteDataSourceImplementation implements AuthenticationRemoteDataSource{
  const AuthenticationRemoteDataSourceImplementation(this._client);
  final http.Client _client;

  @override
  Future<void> createUser({required String createdAt, required String name, required String avatar})async {
    // TODO: implement createUser
    // check to make sure that it returns the right data when the response is successful
    // core is 200 or proper response core
    //check to make sure that it throws an custom exception when the response is unsuccessful
    try{

      final response=await _client.post(Uri.https(kBaseUrl,kCreateUserEndpoint),body:jsonEncode({
        "createdAt": createdAt,
        "name": name,
        "avatar": avatar
      }),
        headers: {
          "Content-Type":"application/json"
        }
      );
      if(response.statusCode!=200 && response.statusCode!=201){
        throw ApiException(message: response.body, statusCode: response.statusCode);
      }
    } on ApiException{
      rethrow;
    }
    catch(e){
      throw ApiException(message: e.toString(), statusCode:505);
    }

  }

  @override
  Future<List<UserModel>> getUsers() async{

    try{

      final response=await _client.get(Uri.https(kBaseUrl,kGetUserEndpoint));

      if(response.statusCode!=200){
        throw ApiException(message: response.body, statusCode: response.statusCode);
      }

      return List<DataMap>.from(jsonDecode(response.body) as List).map((userData)=> UserModel.fromMap(userData)).toList();

    } on ApiException{
      rethrow;
    }
    catch(e){
      throw ApiException(message: e.toString(), statusCode: 505);
    }

  }

}