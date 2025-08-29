import 'package:equatable/equatable.dart';

class User extends Equatable{
  final String id;
  final String createdAt;
  final String name;
  final String avatar;

  const User({required this.id, required this.createdAt, required this.name, required this.avatar});

  const User.empty():this(id:"1", createdAt: "_empty.createdAt", name: "_empty.name", avatar: "_empty.avatar");

  @override
  // TODO: implement props
  List<Object?> get props => [id]; // id base comparison


  //  for these comparison we have equatable package
  // it do comparison of all the properties of the Object instead of their reference

  // @override
  // bool operator ==(Object other) {
  //   return identical(this, other) // this referentially check both object ||
  //   other is User && other.runtimeType==runtimeType && other.id==id && other.name==name; // here we are doing value equality comparison
  // }
  //
  // @override   // here we write all variables on which we doing comparison in operator method
  // int get hashCode => id.hashCode ^ name.hashCode;

}
// void main(){
//   final now=DateTime.now();
//   final usr1=User(id: 1, createdAt: now.toIso8601String(), name: "furqan", avatar: "/pic.png");
//   final usr2=User(id: 1, createdAt: now.toIso8601String(), name: "furqan", avatar: "/pic.png");
//   print(usr1==usr2);
//
// }