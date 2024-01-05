import 'package:bizcard_app/base/base_viewmodel.dart';
import 'package:bizcard_app/extensions/string_ext.dart';
import 'package:bizcard_app/pages/authentication/signup/fragments/company_fragment.dart';
import 'package:bizcard_app/pages/authentication/signup/fragments/contact_fragment.dart';
import 'package:bizcard_app/pages/authentication/signup/fragments/create_fragment.dart';
import 'package:bizcard_app/pages/authentication/signup/cubit/page_cubit.dart';
import 'package:bizcard_app/pages/authentication/signup/fragments/name_fragment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';

class SignupViewModel extends BaseViewModel {

  late PageCubit cubit;
  late PageController pageController;
  late int currentIndex;

  late TextEditingController nameController;
  late TextEditingController jobTitleController;
  late TextEditingController companyNameController;
  late TextEditingController phoneNumberController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  final GlobalKey<FormState> formKey = GlobalKey();

  SignupViewModel(){
    cubit = PageCubit();
    currentIndex = 0;
    pageController = PageController(initialPage: 0);

    nameController = TextEditingController();
    jobTitleController = TextEditingController();
    companyNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  List<Widget> getPages(BuildContext context, SignupViewModel viewModel) {
    return [
      NameFragment(viewModel),
      CompanyFragment(viewModel),
      ContactFragment(viewModel),
      CreateFragment(viewModel)
    ];
  }

  void onCubitChange(BuildContext context, int index) {
    if((index > (pageController.page ?? 0.0)) && !formKey.currentState!.validate()){
      context.read<PageCubit>().onPageChange(-1);
      return;
    }
    pageController.jumpToPage(index);
  }

  onSignupClick(BuildContext context){
    
    if(!formKey.currentState!.validate()){
      context.read<PageCubit>().onPageChange(-1);
      return;
    }
    FocusScope.of(context).unfocus();
    context.read<AuthBloc>().add(
      SignupEvent(
        email: emailController.trim(),
        password: passwordController.trim(),
        name: nameController.trim(),
        companyName: companyNameController.trim(),
        jobTitle: jobTitleController.trim(),
        phoneNumber: phoneNumberController.trim()
      )
    );
  }
  
  @override
  void dispose() {

  }
}