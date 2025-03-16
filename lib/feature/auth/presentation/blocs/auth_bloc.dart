import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_project/feature/auth/domain/usecases/auth_use_case.dart';
import 'package:task_project/feature/auth/presentation/blocs/auth_event.dart';
import 'package:task_project/feature/auth/presentation/blocs/auth_state.dart';



class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final SignOutUseCase signOutUseCase;

  static AuthBloc get(BuildContext context) => BlocProvider.of(context);


  AuthBloc({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.signOutUseCase,
  }) : super(AuthInitial()) {
    on<SignInEvent>((event, emit) async {
      await singIn(event, emit);
    });

    on<SignUpEvent>((event, emit) async {
      await singUp(event, emit);
    });

    on<SignOutEvent>((event, emit) async {
      emit(AuthInitial());
      await signOutUseCase();
      emit(Unauthenticated());
    });

    on<CheckAuthStatusEvent>((event, emit) {
      checkUserStatus(event, emit);
    });
  }
  
  checkUserStatus(event,emit){
    final user = signInUseCase.repository.getCurrentUser();
    if (user != null) {
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  singIn(event, emit)async{
    if (event.email.isEmpty || event.password.isEmpty) {
      emit(AuthError("Email and password cannot be empty"));
      return;
    }
    emit(AuthLoading());
    try {
      final user = await signInUseCase(event.email, event.password);
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(AuthError('Login failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  singUp(event, emit)async{
    if (event.email.isEmpty || event.password.isEmpty) {
      emit(AuthError("Email and password cannot be empty"));
      return;
    }
    emit(AuthLoading());
    try {
      final user = await signUpUseCase(event.email, event.password);
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(AuthError('Signup failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
