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
      await AuthService().login(email: event.email, password: event.password);

      emit(Success());
    }catch(err){
      emit(Error());
    }
  }

  void _onSignup(SignupEvent event, Emitter emit)async{
    try{

      List names = event.name.split(' ');

      var data = await AuthService().signup(
        datamap: {
          'email': event.email, 
          'password': event.password,
          'companyName': event.companyName,
          'jobTitle': event.jobTitle,
          'phoneNumber': event.phoneNumber,
          'firstName': names[0],
          'lastName': names.length>1 ? names[1]: '',
        });

      print(data);

      emit(Success());
    }catch(err){
      emit(Error());
    }
  }
}
