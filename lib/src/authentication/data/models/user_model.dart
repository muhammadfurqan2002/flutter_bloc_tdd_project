import 'dart:convert';

import 'package:tdd_architecture/src/authentication/domain/entities/user.dart';

import '../../../../code/utils/typedef.dart';

class UserModel extends User{
  const UserModel({required super.id, required super.createdAt, required super.name, required super.avatar});

  const UserModel.empty():this(id:"1", createdAt: "_empty.createdAt", name: "_empty.name", avatar: "_empty.avatar");


  //Json serialization

  factory UserModel.fromJson(String source)=> UserModel.fromMap(jsonDecode(source) as DataMap);

  UserModel.fromMap(DataMap map): this(         // for converting server response into our model
    avatar: map["avatar"] as String,
    createdAt: map["createdAt"] as String,
    id: map["id"] as String,
    name: map["name"] as String,
  );


  UserModel copyWith({
    String? id,
    String? createdAt,
    String? name,
    String? avatar,
}){ return UserModel(id: id??this.id, createdAt: createdAt??this.createdAt, name: name??this.name, avatar: avatar??this.avatar);}


  DataMap toMap()=>{
    'id':id,
    'createdAt':createdAt,
    'name':name,
    'avatar':avatar,
  };

  String toJson()=>jsonEncode(toMap()); // for sending data to server

}
//
// void main(){
//   const user=UserModel.empty();
//   final newUser=user.copyWith(id: "2");
//   print(newUser.id);
// }