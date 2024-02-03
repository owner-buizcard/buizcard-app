import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:bizcard_app/pages/settings/integrations/integration_viewmodel.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/input_field_wl.dart';
import 'package:bizcard_app/pages/widgets/row_expanded.dart';
import 'package:flutter/material.dart';

class SaveWhatsappSheet extends StatelessWidget {
  final IntegrationViewModel viewModel;
  final VoidCallback onSave;
  const SaveWhatsappSheet({super.key, required this.viewModel, required this.onSave});

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
            
            'Save Whatsapp Number'.titletext(context),
      
            const Gap(size: 24),
      
            InputFieldWL(
              label: 'Whatsapp Number', 
              controller: viewModel.numberController,
              isRequired: true,
              autofocus: true,
            ),

            const Gap(size: 16),

            ValueListenableBuilder(
              valueListenable: viewModel.enableWhatsapp,
              builder: (_,val, __) {
                return SwitchListTile(
                  value: val, 
                  title: Align(
                    alignment: Alignment.centerRight,
                    child: 'Receive notifications'.bltext(context, color: 'dark'),
                  ),
                  onChanged: (v) => viewModel.enableWhatsapp.value = v
                );
              }
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
                  onPressed: (){
                    FocusScope.of(context).unfocus();
                    onSave();
                  }, 
                  child: const Text('Save'))
              ],
            )
      
          ]
        ),
      ),
    );
  }
}