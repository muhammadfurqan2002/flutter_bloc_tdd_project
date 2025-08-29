import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_architecture/code/utils/typedef.dart';
import 'package:tdd_architecture/src/authentication/data/models/user_model.dart' show UserModel;
import 'package:tdd_architecture/src/authentication/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main(){
  const tModel=UserModel.empty();
  // Act

  test("should be a subclass of [User] entity", (){
    // Arrange

    // Assert
    expect(tModel, isA<User>());

  });

  final tJson=fixture('user.json');
  final tMap=jsonDecode(tJson) as DataMap;
  group('fromMap', (){
    test("should return a [UserModel] with right data", (){
      // Arrange


      // Act
      final result=UserModel.fromMap(tMap);
      expect(result, equals(tModel));
    });
  });
  group('fromMap', (){
    test("should return a [UserModel] with right data", (){
      // Arrange


      // Act
      final result=UserModel.fromJson(tJson);
      expect(result, equals(tModel));
    });
  });
  group('toMap', (){
    test("should return a [Map] with right data", (){
      // Arrange


      // Act
      final result=tModel.toMap();
      expect(result, equals(tMap));
    });
  });
  group('toJson', (){
    test("should return a [Json] string with right data", (){
      // Arrange

        final tJson=jsonEncode({
          "id": "1",
          "createdAt": "_empty.createdAt",
          "name": "_empty.name",
          "avatar": "_empty.avatar"
        });
      // Act
      final result=tModel.toJson();
      // final
      expect(result, equals(tJson));
    });
  });
  group('copyWith', (){

    test("should return a [UserModel] with right data", () {
      final result = tModel.copyWith(name: "Furqan");
      expect(result.name, equals("Furqan"));
    });
  });
}