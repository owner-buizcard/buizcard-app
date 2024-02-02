import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:bizcard_app/pages/dashboard/dashboard_viewmodel.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/input_field_wl.dart';
import 'package:bizcard_app/pages/widgets/main_card.dart';
import 'package:flutter/material.dart';

class MailSheet extends StatelessWidget {
  final DashboardViewModel viewModel;
  final VoidCallback onSave;
  const MailSheet({super.key, required this.viewModel, required this.onSave});

  @override
  Widget build(BuildContext context) {

    return FractionallySizedBox(
      heightFactor: 0.9,
      child: Form(
        key: viewModel.mailFormKey,
        child: MainCard(
          color: Colors.white,
          p: EdgeInsets.zero,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  InkWell(onTap: ()=>Navigator.pop(context), child: const Icon(AntIcons.arrowLeftOutlined)),
                  const Gap(size: 16),
                  Expanded(child: Text('Send Mail', style: Theme.of(context).textTheme.titleSmall,)),
                  TextButton(
                  onPressed: (){
                    FocusScope.of(context).unfocus();
                    onSave();
                  },
                  child: const Text("Send")),
                ],
              ),
              const Gap(size: 16),
              'To email'.btext(context, color: 'dark'),
              const Gap(size: 10),
              const MainCard(child: Text('dhana.spiderlingz@gmail.com')),
              const Gap(size: 16),
              InputFieldWL(
                label: 'Subject',
                isRequired: true, 
                controller: viewModel.subjectController),
              const Gap(size: 16),
              InputFieldWL(
                label: 'Body', 
                maxLines: 10,
                isRequired: true,
                controller: viewModel.contentController),
            ]
          ),
        ),
      ),
    );
  }
}