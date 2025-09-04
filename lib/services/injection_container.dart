import 'package:get_it/get_it.dart';
import 'package:tdd_architecture/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_architecture/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:tdd_architecture/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_architecture/src/authentication/domain/usecases/create_user.dart';
import 'package:tdd_architecture/src/authentication/domain/usecases/get_user.dart';
import 'package:tdd_architecture/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:http/http.dart' as http;

final sl=GetIt.instance;


Future<void> init()async{
  // app logic
  sl.registerFactory(()=>AuthenticationCubit(createUser: sl(), getUser:sl()));

  // these are usecases
  sl.registerLazySingleton(()=>CreateUser(sl()));
  sl.registerLazySingleton(()=>GetUsers(repository: sl()));

  //  Repositories
  //it means whenever someone search for Authentication repo give me the implementation of it
  sl.registerLazySingleton<AuthenticationRepository>(()=>AuthenticationRepositoryImplementation(sl()));



  // Data sources

  // same as previous but for data source
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(()=>AuthenticationRemoteDataSourceImplementation(sl()));



  // External Dependencies

  // both are same but for client
  // sl.registerLazySingleton(()=>http.Client());
  sl.registerLazySingleton(http.Client.new);

}

