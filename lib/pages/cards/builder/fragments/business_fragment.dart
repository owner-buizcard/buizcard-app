import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/pages/widgets/avatar_ph.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/gap.dart';
import '../../../widgets/input_field.dart';
import '../../../widgets/row_expanded.dart';
import '../card_builder_viewmodel.dart';

class BusinessFragment extends StatelessWidget {
  final CardBuilderViewModel viewModel;
  const BusinessFragment({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 45),
      children: [
        Text('Business Details',
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w700, fontSize: 28)),
        const Gap(size: 20),

        Container(
          alignment: Alignment.centerLeft,
          child: const AvatarPH(
            icon: AntIcons.pictureOutlined,
          )
        ),

        const Gap(size: 16),
        RowExpanded(
          gap: 16,
          children: [
            InputField(
              label: 'Job Title',
              controller: viewModel.titleController,
            ),
            InputField(
              label: 'Company Name',
              controller: viewModel.companyNameController,
            ),
          ],
        ),
        const Gap(size: 16),
        InputField(
          label: 'Department',
          controller: viewModel.departmentController,
        ),
        const Gap(size: 16),
        InputField(
          label: 'Company Website',
          controller: viewModel.companyWebsiteController,
        ),
        const Gap(size: 16),
        InputField(
          label: 'About Company',
          maxLines: 4,
          controller: viewModel.aboutController,
        )
      ],
    );
  }
}