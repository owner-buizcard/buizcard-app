import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/pages/dashboard/dashboard_viewmodel.dart';
import 'package:bizcard_app/pages/widgets/contact_item.dart';
import 'package:bizcard_app/utils/global.dart';
import 'package:flutter/material.dart';

import '../../widgets/gap.dart';
import '../../widgets/input_field.dart';

class MyContactsFragment extends StatelessWidget {
  final DashboardViewModel viewModel;
  const MyContactsFragment({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('My Contacts', style: Theme.of(context).textTheme.titleMedium),
          const Gap(size: 16),
          InputField(
            hint: 'Search contacts...', 
            suffixIcon: AntIcons.searchOutlined,
            controller: TextEditingController()
          ),
          const Gap(size: 16),
          Expanded(child: ListView(
            children: Global.contacts.map(
              (e) => ContactItem(
                contact: e,
                onOptionsClick: (v)=>viewModel.openContactOptions(e.id, context),
              )).toList()
          ))
        ])
    );
  }
}