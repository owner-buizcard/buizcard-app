import 'package:bizcard_app/pages/account/edit/edit_account_viewmodel.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/input_field_wl.dart';
import 'package:bizcard_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/image/image_bloc.dart';
import '../../widgets/avatar_ph.dart';
import '../bloc/account_bloc.dart';

class EditAccountView extends StatefulWidget {
  const EditAccountView({super.key});

  @override
  State<EditAccountView> createState() => _EditAccountViewState();
}

class _EditAccountViewState extends State<EditAccountView> {
  late EditAccountViewModel _viewModel;

  @override
  void initState() {
    _viewModel = EditAccountViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ImageBloc, ImageState>(
          listener: (context, state) {
            if (state is UploadedSuccess) {
              if (state.type == 'picture') {
                _viewModel.picture.value = state.link;
              }
            }
          },
        ),
        BlocListener<AccountBloc, AccountState>(
          listener: (context, state) {
            if(state is UserUpdated){
              toast('User updated successfully!', success: true);
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xfffbfbfb),
        appBar: AppBar(
          title: const Text('Edit Account'),
          actions: [
            TextButton(
                onPressed: () => _viewModel.update(context),
                child: const Text("Save")),
            const Gap(size: 8)
          ],
        ),
        body: Form(
          key: _viewModel.formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('PERSONAL',
                  style: GoogleFonts.inter().copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Colors.blueGrey)),
              const Gap(size: 16),
              Align(
                alignment: Alignment.center,
                child: ValueListenableBuilder(
                    valueListenable: _viewModel.picture,
                    builder: (_, value, __) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () async =>
                            await _viewModel.pickImage(context, 'picture'),
                        child: AvatarPH(radius: 50, image: value),
                      );
                    }),
              ),
              const Gap(size: 32),
              Row(
                children: [
                  Expanded(
                    child: InputFieldWL(
                        label: 'First name',
                        controller: _viewModel.fnameController,
                        isRequired: true),
                  ),
                  const Gap(size: 16),
                  Expanded(
                    child: InputFieldWL(
                        label: 'Last name',
                        controller: _viewModel.lnameController,
                        isRequired: true),
                  )
                ],
              ),
              const Gap(size: 16),
              InputFieldWL(
                  label: 'Phone Number',
                  controller: _viewModel.phoneController),
              const Gap(size: 16),
              InputFieldWL(
                  label: 'Secondary Email Address',
                  controller: _viewModel.sEmailController,
                  validationType: 'email'),
              const Gap(size: 16),
              InputFieldWL(
                  label: 'Secondary Phone Number',
                  controller: _viewModel.sPhoneController),
              const Gap(size: 24),
              Text('COMPANY',
                  style: GoogleFonts.inter().copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Colors.blueGrey)),
              const Gap(size: 16),
              InputFieldWL(
                  label: 'Name', controller: _viewModel.cnameController),
              const Gap(size: 16),
              Row(
                children: [
                  Expanded(
                    child: InputFieldWL(
                        label: 'Website',
                        controller: _viewModel.cwebsiteController),
                  ),
                  const Gap(size: 16),
                  Expanded(
                    child: InputFieldWL(
                        label: 'Designation',
                        controller: _viewModel.designationController),
                  )
                ],
              ),
              const Gap(size: 24),
              Text('ADDRESS',
                  style: GoogleFonts.inter().copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Colors.blueGrey)),
              const Gap(size: 16),
              InputFieldWL(
                  label: 'Street / Home',
                  controller: _viewModel.addressController,
                  maxLines: 3),
              const Gap(size: 16),
              Row(
                children: [
                  Expanded(
                    child: InputFieldWL(
                        label: 'State', controller: _viewModel.stateController),
                  ),
                  const Gap(size: 16),
                  Expanded(
                    child: InputFieldWL(
                        label: 'Country',
                        controller: _viewModel.countryController),
                  )
                ],
              ),
              const Gap(size: 64)
            ],
          ),
        ),
      ),
    );
  }
}
