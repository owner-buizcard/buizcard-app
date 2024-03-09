import 'package:bizcard_app/models/user.dart';
import 'package:bizcard_app/network/service/auth_service.dart';
import 'package:bizcard_app/network/service/user_service.dart';
import 'package:bizcard_app/utils/toast.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../database/local_db.dart';
import '../../../network/service/main_service.dart';
import '../../../utils/global.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<SignupEvent>(_onSignup);
    on<SocialLoginEvent>(_onSocialLogin);
    on<EmailVerificationEvent>(_onEmailVerification);
    on<ForgotPasswordEvent>(_onForgotPassword);
    on<ResetPasswordEvent>(_onResetPassword);
    on<UploadPictureEvent>(_onUploadPicture);
    on<InitAppEvent>(_onInitApp);
  }

  void _onInitApp(InitAppEvent event, Emitter emit)async{
    try{  
      var value = await AuthService().init();
      Global.init(value);
      emit(PhotoSuccess());
    }catch(err){
      emit(Error());
    }
  }

  void _onUploadPicture(UploadPictureEvent event, Emitter emit)async{
    try{  
      showLoader();
      await UserService().update({'picture': event.picture}, loader: false);
      var value = await AuthService().init(loader: false);
      Global.init(value);
      emit(PhotoSuccess());
    }catch(err){
      emit(Error());
    }finally{
      hideLoader();
    }
  }

  void _onLogin(LoginEvent event, Emitter emit)async{
    try{  
      showLoader();
      await AuthService().login(email: event.email, password: event.password);
      var value = await MainService().fetchMainData(loader: false);
      Global.init(value);
      emit(Success());
    }catch(err){
      emit(Error());
    }finally{
      hideLoader();
    }
  }

  void _onSocialLogin(SocialLoginEvent event, Emitter emit)async{
    try{  
      Uri uri = Uri.parse(event.link);
      String? token = uri.queryParameters['token'];
      LocalDB.saveToken({'accessToken': token});
      var value = await MainService().fetchMainData(loader: false);
      Global.init(value);
      emit(Success());
    }catch(err){
      emit(Error());
    }
  }

  void _onEmailVerification(EmailVerificationEvent event, Emitter emit)async{
    try{  
      Uri uri = Uri.parse(event.link);
      String? token = uri.queryParameters['token'];
      LocalDB.saveToken({'accessToken': token});
      await AuthService().verifyEmail();
      var value = await MainService().fetchMainData(loader: false);
      Global.init(value);
      emit(Success());
    }catch(err){
      emit(Error());
    }
  }

  void _onSignup(SignupEvent event, Emitter emit)async{
    try{
      showLoader();
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

      Global.user = User.fromJson(data['createdUser']);
      emit(Success());
    }catch(err){
      emit(Error());
    }finally{
      hideLoader();
    }
  }

  void _onForgotPassword(ForgotPasswordEvent event, Emitter emit)async{
    try{

      await AuthService().forgotPassword(email: event.email);

      emit(Success());
    }catch(err){
      emit(Error());
    }
  }

  void _onResetPassword(ResetPasswordEvent event, Emitter emit)async{
    try{

      Uri uri = Uri.parse(event.link);
      String? token = uri.queryParameters['token'];
      LocalDB.saveToken({'accessToken': token});
      
      await AuthService().resetPassword(password: event.password);

      emit(Success());
    }catch(err){
      emit(Error());
    }
  }
}
