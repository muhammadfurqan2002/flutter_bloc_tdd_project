import 'package:equatable/equatable.dart';
import 'package:tdd_architecture/code/errors/exceptions.dart';
abstract class Failure extends Equatable {
  final dynamic message;
  final dynamic statusCode;

  const Failure({required this.message,required this.statusCode});


  @override
  // TODO: implement props
  List<Object?> get props => [message,statusCode];

}


class ApiFailure extends Failure{
  const ApiFailure({required super.message, required super.statusCode});

  ApiFailure.fromException(ApiException exception):this(message: exception.message, statusCode: exception.statusCode);

}