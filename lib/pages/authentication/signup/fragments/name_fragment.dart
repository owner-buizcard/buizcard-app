
import 'package:bizcard_app/pages/authentication/signup/cubit/page_cubit.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/input_field_wl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
          Text('Let’s get started',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w700, fontSize: 28)),
          Text('Hello, Introduce yourself',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: const Color(0xFFB0B0B0))),
          const Gap(size: 20),
          InputFieldWL(
              controller: viewModel.nameController,
              isRequired: true,
              label: 'Enter your name'),
          const Gap(size: 32),
          ElevatedButton(
              onPressed: () => context.read<PageCubit>().onPageChange(1),
              child: const Text('Continue')),
        ],
      ),
    );
  }
}
