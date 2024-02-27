import 'package:bizcard_app/base/base_viewmodel.dart';
import 'package:bizcard_app/extensions/string_ext.dart';
import 'package:bizcard_app/pages/authentication/password/success_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../routes/app_routes.dart';
import '../../bloc/auth_bloc.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  late TextEditingController emailController;

  final GlobalKey<FormState> formKey = GlobalKey();

  ForgotPasswordViewModel(){
    emailController = TextEditingController();
  }

  onForgotClick(BuildContext context){
    if(!formKey.currentState!.validate()){
      return;
    }
    FocusScope.of(context).unfocus();
    context.read<AuthBloc>().add(
      ForgotPasswordEvent(email: emailController.trim())
    );
  }

  successSheet(BuildContext context){
    showModalBottomSheet(
      context: context, 
      isDismissible: false,
      enableDrag: false,
      builder: (_){
        return SuccessSheet(
          title: 'Check your email !',
          content: 'We have sent a password recover instructions to your email.',
          onClick: ()=>Navigator.pushNamedAndRemoveUntil(context, Routes.login, (route) => false)
        );
      });
  }

  @override
  void dispose() {

  }

}