import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:bizcard_app/models/field.dart';
import 'package:bizcard_app/pages/cards/links/link_store_viewmodel.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/input_field_wl.dart';
import 'package:bizcard_app/pages/widgets/main_card.dart';
import 'package:flutter/material.dart';

class AddLinkSheet extends StatelessWidget {
  final Field field;
  final LinkStoreViewModel viewModel;
  final VoidCallback onAdd;
  const AddLinkSheet({super.key, required this.field, required this.viewModel, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Form(
        key: viewModel.formKey,
        child: Column(
          children: [  
            AppBar(
              title: Text(field.label),
              centerTitle: true,
              backgroundColor: Colors.transparent
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    MainCard(
                      child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/bizcard-web.appspot.com/o/${field.icon}',
                      width: double.infinity,
                      height: 120
                    )),
                    const Gap(size: 16),
                    InputFieldWL(
                      label: '${field.label} Link', 
                      hint: 'Enter link here',
                      isRequired: true,
                      controller: viewModel.linkController
                    ),
                    const Gap(size: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 8
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0x268c8c8c),
                        borderRadius: BorderRadius.circular(4)
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.paste, size: 14),
                          const Gap(size: 8),
                          'Paste from Clipboard'.btext(context, color: 'darker')
                        ],
                      ),
                    ),
                  
                    const Gap(size: 45),
                  
                    ElevatedButton(
                      onPressed: ()=>onAdd(),
                      child: const Text('Add Link')
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}