import 'package:bizcard_app/base/base_viewmodel.dart';
import 'package:bizcard_app/extensions/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc.dart';
import 'bottomsheets/success_sheet.dart';

class ResetPasswordViewModel extends BaseViewModel {
  late TextEditingController passwordController;
  late TextEditingController confirmController;
  late String resetLink;

  final GlobalKey<FormState> formKey = GlobalKey();

  ResetPasswordViewModel(String link){
    passwordController = TextEditingController();
    confirmController = TextEditingController();
    resetLink = link;
  }

  onResetClick(BuildContext context){
    if(!formKey.currentState!.validate()){
      return;
    }
    FocusScope.of(context).unfocus();
    context.read<AuthBloc>().add(
      ResetPasswordEvent(password: passwordController.trim(), link: resetLink)
    );
  }

  successSheet(BuildContext context){
    showModalBottomSheet(
      context: context, 
      isDismissible: false,
      enableDrag: false,
      builder: (_){
        return const SuccessSheet();
      });
  }

  @override
  void dispose() {

  }

}