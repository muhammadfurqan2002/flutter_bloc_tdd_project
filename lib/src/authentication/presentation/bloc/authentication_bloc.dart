import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_architecture/src/authentication/domain/entities/user.dart';

import '../../domain/usecases/create_user.dart';
import '../../domain/usecases/get_user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
  {
    required  CreateUser createUser,
    required GetUsers getUser
  }) : _createUser=createUser,
        _getUser=getUser,
        super(AuthenticationInitial()) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetUserEvent>(_getUserHandler);
  }
  final CreateUser _createUser;
  final GetUsers _getUser;
  Future<void> _createUserHandler(CreateUserEvent event,Emitter<AuthenticationState> emit)async{
    emit(const CreatingUser());
    final result=await _createUser(CreateUserParams(createdAt: event.createdAt, name: event.name, avatar: event.avatar));
    result.fold((failure)=>emit(AuthenticationError(failure.errorMessage)),
            (_)=>emit(UserCreated()));
  }

  Future<void> _getUserHandler(GetUserEvent event,Emitter<AuthenticationState> emit)async{
    emit(GettingUsers());
    final result=await _getUser();
    result.fold((failure)=>emit(AuthenticationError(failure.errorMessage)),
            (users)=>emit(UsersLoaded(users)));

  }
}
