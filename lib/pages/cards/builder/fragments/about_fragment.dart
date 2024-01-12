
import 'package:bizcard_app/pages/widgets/avatar_ph.dart';
import 'package:bizcard_app/pages/widgets/banner_ph.dart';
import 'package:bizcard_app/pages/widgets/input_field.dart';
import 'package:bizcard_app/pages/widgets/row_expanded.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/gap.dart';
import '../card_builder_viewmodel.dart';

class AboutFragment extends StatelessWidget {
  final CardBuilderViewModel viewModel;
  const AboutFragment({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 45),
      children: [
        Text('Personal Details', style: Theme.of(context).textTheme.titleMedium),
        const Gap(size: 20),
        
        const SizedBox(
          height: 200,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              BannerPH(),
              Positioned(
                bottom: 0,
                child: AvatarPH()
              ),
            ],
          ),
        ),

        const Gap(size: 16),

        RowExpanded(
          gap: 16,
          children: [
            InputField(
              label: 'First Name',
              controller: viewModel.fNameController,
            ),
            InputField(
              label: 'Last Name',
              controller: viewModel.lNameController,
            ),
          ],
        ),
        const Gap(size: 16),
        RowExpanded(
          gap: 16,
          children: [
            InputField(
              label: 'Middle Name',
              controller: viewModel.mNameController,
            ),
            InputField(
              label: 'Prefix',
              controller: viewModel.prefixController,
            ),
          ],
        ),
        const Gap(size: 16),
        InputField(
          label: 'Bio',
          maxLines: 2,
          controller: viewModel.bioController,
        ),
        const Gap(size: 20),
        Text('Contact', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w400)),
        const Gap(size: 20),
        RowExpanded(
          gap: 16,
          children: [
            InputField(
              label: 'Email Address',
              controller: viewModel.emailController,
            ),
            InputField(
              label: 'Phone Number',
              controller: viewModel.phoneController,
            ),
          ],
        ),
        const Gap(size: 16),
        InputField(
          maxLines: 2,
          label: 'Address',
          controller: viewModel.addressController,
        ),
        const Gap(size: 16),
        RowExpanded(
          gap: 16,
          children: [
            InputField(
              label: 'City',
              controller: viewModel.cityController,
            ),
            InputField(
              label: 'State',
              controller: viewModel.stateController,
            ),
          ],
        ),
        const Gap(size: 16),
        RowExpanded(
          gap: 16,
          children: [
            InputField(
              label: 'Country',
              controller: viewModel.countryController,
            ),
            InputField(
              label: 'Pincode',
              controller: viewModel.pincodeController,
            ),
          ],
        ),
      ],
    );
  }
}