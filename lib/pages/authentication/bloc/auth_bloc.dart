import 'package:bizcard_app/network/service/auth_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  

  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<SignupEvent>(_onSignup);
  }

  void _onLogin(LoginEvent event, Emitter emit)async{
    try{  
      var data = await AuthService().login(email: event.email, password: event.password);

      emit(Success());
    }catch(err){
      emit(Error());
    }
  }

  void _onSignup(SignupEvent event, Emitter emit)async{
    try{

      emit(Success());
    }catch(err){
      emit(Error());
    }
  }
}
