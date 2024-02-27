
import 'package:bizcard_app/components/styled_button.dart';
import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:bizcard_app/pages/authentication/signup/cubit/page_cubit.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/input_field_wl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../signup_viewmodel.dart';

class NameFragment extends StatelessWidget {
  final SignupViewModel viewModel;
  const NameFragment(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          Text('Let’s get started', style: Theme.of(context).textTheme.titleMedium),
          'Hello, Introduce yourself'.btext(context),
          const Gap(size: 20),
          InputFieldWL(
              controller: viewModel.nameController,
              isRequired: true,
              autofocus: true,
              label: 'Enter your name'),
          const Gap(size: 32),
          StyledButton(
            onPressed: ()=>context.read<PageCubit>().onPageChange(1), 
            text: 'Continue'
          ),
          // ElevatedButton(
          //     style: ElevatedButtonTheme.of(context).style!.copyWith(
          //         padding: const MaterialStatePropertyAll(EdgeInsets.all(16)),
          //         foregroundColor: const MaterialStatePropertyAll(Colors.white),
          //         side: const MaterialStatePropertyAll(BorderSide(color: Color.fromARGB(255, 59, 112, 203), width: 0)),
          //         backgroundColor: const MaterialStatePropertyAll(Color(0xFF2A5298)),
          //       ),
          //     onPressed: () => context.read<PageCubit>().onPageChange(1),
          //     child: Text('Continue', style: GoogleFonts.aBeeZee().copyWith(
          //             fontSize: 18,
          //             fontWeight: FontWeight.w500
          //     )))
        ],
      ),
    );
  }
}
