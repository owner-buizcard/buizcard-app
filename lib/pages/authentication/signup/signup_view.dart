import 'package:bizcard_app/pages/authentication/signup/cubit/page_cubit.dart';
import 'package:bizcard_app/pages/authentication/signup/signup_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  late SignupViewModel _viewModel;

  @override
  void initState() {
    _viewModel = SignupViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var pages = _viewModel.getPages(context, _viewModel);

    return MultiBlocListener(
      listeners: [
        BlocListener<PageCubit, int>(
          listener: (_, index){
            if(index>=0){
              _viewModel.onCubitChange(context, index);
            }
          }
        ),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {

          },
        ),
      ],
      child: Form(
        key: _viewModel.formKey,
        child: PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: pages.length,
          controller: _viewModel.pageController,
          itemBuilder: (_, index) => pages[index],
        ),
      ),
    );
  }
}
