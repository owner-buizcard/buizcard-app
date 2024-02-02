import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:bizcard_app/pages/dashboard/dashboard_viewmodel.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/input_field_wl.dart';
import 'package:bizcard_app/pages/widgets/row_expanded.dart';
import 'package:flutter/material.dart';

class CreateCardSheet extends StatelessWidget {
  final DashboardViewModel viewModel;
  final VoidCallback onCreate;
  const CreateCardSheet({super.key, required this.viewModel, required this.onCreate});

  @override
  Widget build(BuildContext context) {

    return Form(
      key: viewModel.formKey,
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          physics: const NeverScrollableScrollPhysics(),
          children: [
            
            'Create Card'.titletext(context),
      
            const Gap(size: 24),
      
            InputFieldWL(
              label: 'Card Name', 
              controller: viewModel.cardnameController,
              isRequired: true,
              autofocus: true,
            ),
            
            const Gap(size: 32),
      
            RowExpanded(
              gap: 24,
              children: [
                OutlinedButton(
                  onPressed: ()=>Navigator.pop(context), 
                  style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
                    foregroundColor: const MaterialStatePropertyAll(Colors.deepOrange),
                    side: const MaterialStatePropertyAll(BorderSide(color: Colors.deepOrange)),
                  ),
                  child: const Text('Cancel')),
                ElevatedButton(
                  onPressed: onCreate, 
                  child: const Text('Create'))
              ],
            )
      
          ]
        ),
      ),
    );
  }
}