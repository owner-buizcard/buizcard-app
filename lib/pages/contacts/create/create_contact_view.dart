import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/models/contact.dart';
import 'package:bizcard_app/models/contact_info.dart';
import 'package:bizcard_app/pages/contacts/create/create_contact_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/image/image_bloc.dart';
import '../../widgets/avatar_ph.dart';
import '../../widgets/gap.dart';
import '../../widgets/input_field.dart';
import '../../widgets/row_expanded.dart';
import '../bloc/contacts_bloc.dart';

class CreateContactView extends StatefulWidget {
  final ContactInfo? info;
  final Contact? contact;
  const CreateContactView({super.key, this.info, this.contact});

  @override
  State<CreateContactView> createState() => _CreateContactViewState();
}

class _CreateContactViewState extends State<CreateContactView> {
  late CreateContactViewModel _viewModel;

  @override
  void initState() {
    _viewModel = CreateContactViewModel(widget.info??widget.contact?.details);
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
        BlocListener<ContactsBloc, ContactsState>(
          listener: (context, state) {
            if(state is ContactCreated || state is ContactUpdated){
              Navigator.pop(context);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.contact!=null ? 'Edit Contact' :'Create Contact'),
          actions: [
            TextButton(
                onPressed: () => _viewModel.onSave(context, widget.contact),
                child: const Text("Save")),
            const Gap(size: 8)
          ],
        ),
        body: Form(
          key: _viewModel.formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ValueListenableBuilder(
                  valueListenable: _viewModel.picture,
                  builder: (_, value, __) {
                    return Container(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(32),
                          onTap: () async =>
                              await _viewModel.pickImage(context, 'picture'),
                          child: AvatarPH(
                            image: value,
                            icon: AntIcons.userOutlined,
                          ),
                        ));
                  }),
              const Gap(size: 36),
              InputField(
                label: 'Name',
                isRequired: true,
                controller: _viewModel.nameController,
              ),
              const Gap(size: 16),
              InputField(
                label: 'Job title',
                controller: _viewModel.titleController,
              ),
              const Gap(size: 16),
              RowExpanded(
                gap: 16,
                children: [
                  InputField(
                    label: 'Email Address',
                    controller: _viewModel.emailController,
                  ),
                  InputField(
                    label: 'Phone Number',
                    controller: _viewModel.phoneController,
                  ),
                ],
              ),
              const Gap(size: 16),
              InputField(
                label: 'Company',
                controller: _viewModel.companyController,
              ),
              const Gap(size: 16),
              InputField(
                label: 'Company Website',
                controller: _viewModel.websiteController,
              ),
              const Gap(size: 16),
              InputField(
                label: 'Location',
                controller: _viewModel.locationController,
              ),
              const Gap(size: 16),
              InputField(
                maxLines: 3,
                label: 'Notes',
                controller: _viewModel.notesController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
