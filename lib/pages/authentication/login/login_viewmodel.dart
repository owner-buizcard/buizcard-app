import 'package:bizcard_app/base/base_viewmodel.dart';
import 'package:bizcard_app/extensions/string_ext.dart';
import 'package:bizcard_app/pages/authentication/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginViewModel extends BaseViewModel {
  
  late TextEditingController emailController;
  late TextEditingController passwordController;

  final GlobalKey<FormState> formKey = GlobalKey();

  LoginViewModel(){
    emailController = TextEditingController(text: '1dhana625@gmail.com');
    passwordController = TextEditingController(text: 'Jeeva@123');
  }

  onLoginClick(BuildContext context){
    
    if(!formKey.currentState!.validate()){
      return;
    }
    FocusScope.of(context).unfocus();
    context.read<AuthBloc>().add(
      LoginEvent(
        email: emailController.trim(), password: passwordController.trim())
    );
  }
  
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}