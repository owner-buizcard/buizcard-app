import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/input_field_wl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/page_cubit.dart';
import '../signup_viewmodel.dart';

class ContactFragment extends StatelessWidget {
  final SignupViewModel viewModel;
  const ContactFragment(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (val){
        context.read<PageCubit>().onPageChange(1);
      },
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            Text(
              'Contact', style: Theme.of(context).textTheme.titleMedium),
            'You can get a lead via text or call'.btext(context),
      
            const Gap(size: 20),
            
            InputFieldWL(
              controller: viewModel.phoneNumberController,
              label: 'Phone Number'  
            ),
      
            const Gap(size: 32),
      
            ElevatedButton(
              onPressed: ()=>context.read<PageCubit>().onPageChange(3),
              child: const Text('Continue')
            ),
      
            const Gap(size: 24),
      
            TextButton(
              onPressed: ()=>context.read<PageCubit>().onPageChange(3), 
              child: const Text('Skip'))
          ],
        ),
      ),
    );
  }
}