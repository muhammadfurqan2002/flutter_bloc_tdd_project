
import '../../../../code/utils/typedef.dart';

abstract class UsecaseWithParams<Type,Params>{
  const UsecaseWithParams();
  ResultFuture<Type> call(Params params);   // call method always call when we create object of this class
}

abstract class UsecaseWithoutParams<Type>{
  const UsecaseWithoutParams();
  ResultFuture<Type> call();
}