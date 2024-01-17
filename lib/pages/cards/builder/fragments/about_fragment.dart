
import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:bizcard_app/pages/widgets/avatar_ph.dart';
import 'package:bizcard_app/pages/widgets/banner_ph.dart';
import 'package:bizcard_app/pages/widgets/input_field.dart';
import 'package:bizcard_app/pages/widgets/row_expanded.dart';
import 'package:flutter/material.dart';

import '../../../widgets/gap.dart';
import '../card_builder_viewmodel.dart';

class AboutFragment extends StatelessWidget {
  final CardBuilderViewModel viewModel;
  const AboutFragment({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16,0,16,45),
      children: [
        Text('Personal Details', style: Theme.of(context).textTheme.titleMedium),
        const Gap(size: 20),
        
        SizedBox(
          height: 200,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              ValueListenableBuilder(
                valueListenable: viewModel.banner,
                builder: (_, value, __) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: ()async =>await viewModel.pickImage(context, 'banner'),
                    child: BannerPH(image: value));
                }
              ),
              ValueListenableBuilder(
                valueListenable: viewModel.picture,
                builder: (_, value, __) {
                  return Positioned(
                    bottom: 0,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: ()async =>await viewModel.pickImage(context, 'picture'),
                      child: AvatarPH(
                        image: value,
                      ))
                  );
                }
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
        'Contact'.bltext(context, color: 'darker'),
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